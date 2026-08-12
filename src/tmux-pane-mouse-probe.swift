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

import CoreGraphics
import Foundation

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
var win: CGRect? = nil

if let list = CGWindowListCopyWindowInfo(
    [.optionOnScreenOnly, .excludeDesktopElements], kCGNullWindowID) as? [[String: Any]] {
    for w in list {
        guard let layer = w[kCGWindowLayer as String] as? Int, layer == 0,
              let owner = w[kCGWindowOwnerName as String] as? String,
              let dict = w[kCGWindowBounds as String] as? NSDictionary,
              let rect = CGRect(dictionaryRepresentation: dict as CFDictionary),
              rect.contains(loc)
        else { continue }

        if topOwner == "?" { topOwner = owner }
        guard owner == "iTerm2" else { continue }

        // Never use a negative-size CGRect as a "not found" sentinel:
        // CGRect.width/.height return standardized (absolute) values, so -1
        // reads back as 1 and yields a phantom 1x1 window.
        if win == nil || rect.width * rect.height > win!.width * win!.height {
            win = rect
        }
    }
}

let found = (win != nil && topOwner == "iTerm2")

let fields: [String] = [
    found ? "1" : "0",
    String(format: "%.2f", secsDown),
    String(format: "%.2f", secsMoved),
    topOwner,
    String(Int(loc.x.rounded())),
    String(Int(loc.y.rounded())),
    String(Int(win?.origin.x ?? 0)),
    String(Int(win?.origin.y ?? 0)),
    String(Int(win?.width ?? 0)),
    String(Int(win?.height ?? 0)),
]
print(fields.joined(separator: "\t"))
