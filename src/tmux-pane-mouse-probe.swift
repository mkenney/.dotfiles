// tmux-pane-mouse-probe -- one-shot pointer/window probe for
// bin/tmux-select-pane-under-mouse.
//
// Reports where the mouse pointer is, how long ago the last click was, and the
// geometry of the iTerm2 window under the pointer. Compiled rather than scripted
// because it runs on every terminal focus event: an equivalent
// `osascript -l JavaScript` helper cost ~40ms against ~4ms here, on a path the
// user can feel.
//
// CoreGraphics only, deliberately. CGEvent's pointer location is already in
// top-left display coordinates -- the same space as CGWindowList bounds -- so no
// coordinate flip and no NSScreen lookup are needed. That removes the one place
// a multi-monitor sign error could hide, and avoids loading AppKit.
//
// Output: one tab-separated line
//   found  secsSinceLeftMouseDown  secsSinceMouseMoved  topOwner
//   pointerX  pointerY  winX  winY  winW  winH
//
// found is 1 only when iTerm2 owns the topmost window under the pointer AND a
// usable iTerm2 window rect was resolved. winX/winY/winW/winH are 0 otherwise.
// topOwner is diagnostic only ("name/bundle-id", or "?" for no window).

import CoreGraphics
import Foundation

// Identify the terminal by BUNDLE ID, not by kCGWindowOwnerName.
//
// That name is a LaunchServices *display* name resolved when the process
// registers with the window server, not a value read from the app bundle. It was
// observed as "iTerm2" and later as "iTerm" for the same untouched 3.6.11 bundle
// -- the machine crashed in between, and the re-derived name fell back to the
// bundle filename (iTerm.app -> "iTerm"). Info.plist CFBundleName still said
// "iTerm2" throughout, and so did lsappinfo's LSDisplayName, so nothing
// observable from the app would have predicted the flip. Matching the name made
// found always 0 and killed the feature silently.
let wantedBundleID = "com.googlecode.iterm2"

// Consulted ONLY when the bundle id cannot be resolved -- see isTerminal below.
// Both spellings are accepted because both have been observed in the wild, and
// the name may well flip again in either direction.
let fallbackOwnerNames: Set<String> = ["iTerm", "iTerm2"]

// pid -> bundle id, "" when the process is not in an .app (or is unreadable).
// Cached because several windows under the pointer usually share one owner, and
// each miss costs a proc_pidpath plus an Info.plist read.
var bundleIDs: [pid_t: String] = [:]

func bundleID(of pid: pid_t) -> String {
    if let hit = bundleIDs[pid] { return hit }

    var id = ""
    var buf = [CChar](repeating: 0, count: 4096)  // PROC_PIDPATHINFO_MAXSIZE
    if proc_pidpath(pid, &buf, UInt32(buf.count)) > 0 {
        // Walk up from the executable to the nearest .app wrapper, e.g.
        // /Applications/iTerm.app/Contents/MacOS/iTerm2 -> /Applications/iTerm.app
        var url = URL(fileURLWithPath: String(cString: buf))
        while url.pathComponents.count > 1 {
            if url.pathExtension == "app" {
                if let bundle = CFBundleCreate(nil, url as CFURL),
                   let cf = CFBundleGetIdentifier(bundle) {
                    id = cf as String
                }
                break
            }
            url = url.deletingLastPathComponent()
        }
    }

    bundleIDs[pid] = id
    return id
}

// The bundle id is authoritative WHEN WE HAVE IT: falling back to the name even
// then would let any app that happens to be called "iTerm" pass a check we could
// have answered exactly. The fallback covers only the case where identity is
// genuinely unavailable -- proc_pidpath denied, or an executable outside any .app
// wrapper -- which would otherwise reject every window and silently kill the
// feature, exactly the failure this file already has scar tissue from.
func isTerminal(bundleID id: String, ownerName name: String) -> Bool {
    id.isEmpty ? fallbackOwnerNames.contains(name) : id == wantedBundleID
}

guard let loc = CGEvent(source: nil)?.location else {
    print("0\t-1\t-1\t?\t0\t0\t0\t0\t0\t0")
    exit(0)
}

let secsDown = CGEventSource.secondsSinceLastEventType(
    .combinedSessionState, eventType: .leftMouseDown)
let secsMoved = CGEventSource.secondsSinceLastEventType(
    .combinedSessionState, eventType: .mouseMoved)

// Both answers come from a single front-to-back pass over on-screen windows.
//
// topOwner is an OCCLUSION test: who owns the topmost window under the pointer.
// That is the question we actually care about -- "is this click landing on
// iTerm2?" -- and unlike asking which application is frontmost, it stays correct
// when another app's window overlaps iTerm2 at that point. (Note that taking the
// first entry of this list as "the frontmost app" is NOT equivalent and is
// wrong; it reports "Window Server" in practice.)
//
// win is the LARGEST iTerm2 window containing the pointer, not the first one.
// iTerm2 also owns a short strip window (observed 1440x68) stacked above the
// real terminal window; matching the first hit would divide by that 68px height
// for any click in the top few rows and yield a nonsense row number.
var topOwner = "?"
var topBundleID = ""
var topIsTerminal = false
var win: CGRect? = nil

if let list = CGWindowListCopyWindowInfo(
    [.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]] {
    for w in list {
        guard let layer = w[kCGWindowLayer as String] as? Int, layer == 0,
              let owner = w[kCGWindowOwnerName as String] as? String,
              let ownerPID = w[kCGWindowOwnerPID as String] as? Int,
              let dict = w[kCGWindowBounds as String] as? NSDictionary,
              let rect = CGRect(dictionaryRepresentation: dict as CFDictionary),
              rect.contains(loc)
        else { continue }

        let id = bundleID(of: pid_t(ownerPID))
        let isTerm = isTerminal(bundleID: id, ownerName: owner)
        if topOwner == "?" {
            topOwner = owner
            topBundleID = id
            topIsTerminal = isTerm
        }
        guard isTerm else { continue }

        // Never use a negative-size CGRect as a "not found" sentinel:
        // CGRect.width/.height return standardized (absolute) values, so -1
        // reads back as 1 and yields a phantom 1x1 window.
        if win == nil || rect.width * rect.height > win!.width * win!.height {
            win = rect
        }
    }
}

let found = (win != nil && topIsTerminal)

let fields: [String] = [
    found ? "1" : "0",
    String(format: "%.2f", secsDown),
    String(format: "%.2f", secsMoved),
    topBundleID.isEmpty ? topOwner : "\(topOwner)/\(topBundleID)",
    String(Int(loc.x.rounded())),
    String(Int(loc.y.rounded())),
    String(Int(win?.origin.x ?? 0)),
    String(Int(win?.origin.y ?? 0)),
    String(Int(win?.width ?? 0)),
    String(Int(win?.height ?? 0)),
]
print(fields.joined(separator: "\t"))
