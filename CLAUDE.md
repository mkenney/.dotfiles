# CLAUDE.md

## Overview

Personal shell environment configuration for macOS/Linux, targeting **zsh** as the primary shell. All dotfiles are installed as symlinks from `~/.dotfiles/` into `$HOME`.

## Installation

```sh
git clone https://github.com/mkenney/.dotfiles.git && ./.dotfiles/init.sh zsh
```

`init.sh` requires a shell argument (`zsh`, `bash`, etc.). On macOS it installs Homebrew tools, sets zsh as login shell, creates symlinks, and installs Vim plugins. **It overwrites conflicting dotfiles without prompting.**

The `link-dotfile` function in `init.sh` creates symlinks: `$HOME/.dotfiles/<src>` → `$HOME/<dest>`.

## Repository Structure

```
conf/       # Config files symlinked to ~ (.gitconfig, .vimrc, .tmux.conf, etc.)
shell/      # All shell configuration
  .shellrc          # Entry point (symlinked to ~/.zshrc)
  common/           # Sourced modules: aliases, path, env, functions, brew, go, docker, terraform, kubectl, nvm, etc.
  fn/               # Autoloaded zsh functions (__didyoumean, auth, k8s, kn, kp, kx, etc.)
  ext/              # Tool extension system (cmd, docker, git, go, kubectl subcommands)
  prompt/           # Prompt: prompt.zsh (zsh), prompt.bash (bash), git-status, k8s-status
  completion/       # Shell completions for bash and zsh
bin/        # Utility binaries (git-status-darwin-amd64, git-status-linux-amd64, git_vimdiff_wrapper, tmux.sh)
```

## Shell Configuration Loading Order

`shell/.shellrc` sources modules in this order:
1. zsh keybindings and completion setup
2. `common/path` → `common/env` → `common/env_platform`
3. `common/aliases`
4. Brew shell env (`/opt/homebrew/bin/brew shellenv`)
5. Tool configs: `brew`, `docker`, `go`, `terraform`, `clickhouse`, `cvs`
6. Extension system: `shell/ext/cmd/init.sh` (loads all `ext/*/init.sh`)
7. `common/functions`
8. Git completion
9. Tool configs: `java`, `kubectl`, `perl`, `nvm`
10. Prompt: `shell/prompt/prompt.zsh`
11. Tool configs: `vim`, `cdpath`, `tmux`
12. Cargo env

Each module is guarded with `[ -f file ] && source file` — missing files are silently skipped.

## Extension System (`shell/ext/`)

Each subdirectory has an `init.sh` that registers subcommands. The `__ext_cmd` dispatcher routes calls to scripts named `__ext_<tool>_<subcommand>`. The `__didyoumean` autoloaded function provides suggestion/correction when invalid subcommands are used.

## Prompt System

- `shell/prompt/prompt.zsh`: Multi-line prompt with git status, kubernetes context/namespace, exit code indicator
- Uses compiled native binary `bin/git-status-darwin-amd64` (or linux) for performance
- `shell/prompt/k8s-status`: Kubernetes context display

## Git Configuration

- All commits are GPG-signed using SSH key (`~/.ssh/github.com.pub`)
- Merge/diff tool: vimdiff (wrapper at `bin/git_vimdiff_wrapper`)
- Work-specific config: `conf/.gitconfig.work` (included via `[includeIf]` or similar)
- `rerere.enabled = true` for remembered conflict resolutions

## Vim Setup

- Plugin manager: Vundle.vim (git submodule at `conf/.vim/bundle/Vundle.vim`)
- Config: `conf/.vimrc`
- To reinstall plugins: `vim +PluginInstall +qall`

## Adding New Shell Configuration

- **Aliases**: Add to `shell/common/aliases`
- **Environment variables**: Add to `shell/common/env` or `shell/common/env_platform` (platform-specific)
- **Functions**: Add autoloaded functions to `shell/fn/` and register with `autoload -Uz <name>` in `.shellrc`
- **New tool module**: Create `shell/common/<tool>`, source it in `.shellrc` with the standard guard pattern
- **New extension**: Create `shell/ext/<tool>/init.sh` and `__ext_<tool>_<subcommand>` scripts
