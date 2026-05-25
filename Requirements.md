# PRD: dev-env — Terminal Development Environment

## Overview

One-command terminal IDE stack: Vim + tmux, targeting C/C++, Python, Go, JavaScript/TypeScript, and CMake development.

## Goals

- Zero-config setup: `install.sh` deploys Vim config, tmux config, and all tooling dependencies
- Idiomatic Vim UX: leader key, splits, quickfix — no modal switching
- Per-language tooling: completion, linting, formatting wired via ALE + YCM
- tmux powerline status bar with git branch display
- Safe updates: plugin snapshot/test/rollback on reinstall

## Non-goals

- Neovim support (Vim 8.2+ only)
- LSP-native completion (uses YCM instead)
- Windows support
- GUI modes

## Target Users

- Systems/C++ developers who need C/C++ tooling
- Go/Python/JS developers needing a consistent terminal IDE
- Developers who prefer terminal-based workflows (tmux + Vim)

## Functional Requirements

### FR1 — Installer (install.sh)

| Sub-feature | Detail |
|---|---|
| Mode selection | `all` (default), `pkg`, `vim`, `tmux` |
| System packages | universal-ctags, clang/clangd/cppcheck, ripgrep, build-essential, cmake, python3-dev, golang-go |
| Tooling | fzf, gopls, yapf, cmake-language-server, cmakelint, cmake-format |
| Idempotent | Safe to re-run; skips already-installed items |
| Plugin snapshot | Before PlugUpdate, records HEAD of each plugin; on Vim crash, rolls back |
| YCM compilation | Builds with clang, ts, go completers |

### FR2 — Vim Configuration

- **Leader key**: Space
- **Core plugins**: vim-plug, YCM, ALE, airline, fugitive, signify, gutentags, LeaderF, fzf, asyncrun, vim-autoformat, echodoc, vim-prettier, dirvish
- **Color schemes**: gruvbox (default), nord, onehalfdark
- **Window nav**: C-h/j/k/l
- **Terminal**: `<Space>\`` toggle, `<Space>w` vertical, `<Space>W` horizontal
- **Search**: FZF for files, LeaderF for MRU/tags/buffers/lines/functions
- **Git**: fugitive (status/commit/push/pull/log/blame), signify (gutter diff)
- **Formatting**: `<Space>i` per-language (clang-format/yapf/prettier/cmake-format/goimports)
- **Build**: F5/F6/F7/F11 per-language
- **Quickfix**: F8/F9/F10

### FR3 — Language Support

| Language | Completion | Linting | Formatting |
|---|---|---|---|
| C/C++ | YCM + clangd | ALE (clang/g++/cppcheck) | clang-format (Google style) |
| Python | YCM (jedi) | ALE | yapf (Google style) |
| JS/TS | YCM (tsserver) | ALE | prettier |
| CMake | YCM (cmake-ls) | ALE (cmakelint) | cmake-format |
| Go | YCM + gopls | ALE (gopls/golangci-lint) | goimports |
| Octave | — | — | — |

### FR4 — tmux Configuration

- **Prefix**: Ctrl-j (double-tap to pass through)
- **Pane split**: `C-j |` vertical, `C-j -` horizontal
- **Pane nav**: `C-j h/j/k/l`
- **Popup terminal**: `C-j Enter` (80% size)
- **Copy mode**: vi keys, `v`/`s` begin, `y`/`c` yank
- **Status bar**: tmux-powerline (session, git branch, hostname, date, time)
- **Synchronize**: `C-j e` on, `C-j E` off

### FR5 — Filetype Plugin System

Per-filetype settings in `vim/ftplugin/`:
- Indent settings (cindent for C, 2-space for CMake, 4-space for Python/Go)
- Language-specific build/run/test keybindings (F5/F7/F11)
- Line-length warning (80 chars for C)
- Prettier formatting for JS/TS/JSX/TSX

### FR6 — Ctags Management

- Gutentags auto-generates `.tags` in project root or `~/.cache/tags`
- Extra fields: paths, icons, labels, sizes
- C++/C kind extensions: templates, namespaces

## Cross-Version Compatibility

Different Linux distros/versions ship significantly different toolchain versions. The installer must adapt dynamically.

### Version Matrix

| System | Go | Node | Vim | apt golang-go |
|---|---|---|---|---|
| Ubuntu 24.04+ | >=1.22 | >=20 | >=9.0 | >=1.22 |
| Ubuntu 22.04 | 1.18 (apt) | 12 (apt) | 8.2.2434 | 1.18 |
| Ubuntu 20.04 | — | 10 | 8.1.0 | — |
| Debian 11 | 1.15 | 12.16 | 8.2.2 | 1.15 |
| Fedora 38+ | >=1.20 | >=18 | >=9.0 | — |

### Adaptation Strategy

| Tool | Detection | Adaptation |
|---|---|---|
| gopls | Go <1.21 | Pin `gopls@v0.13.2` (last release compatible with Go 1.18) |
| Node / YCM ts-completer | Node <18 | Skip `--ts-completer`, warn to install Node 18+ manually |
| Node / prettier | Node <14 | Warn that install may fail |
| Vim wildoptions/pum | Vim <8.2.4325 | `silent! set wildoptions=pum` to skip |
| Vim jumpoptions/stack | Vim <8.2.1497 | `silent! set jumpoptions=stack` to skip |
| termguicolors in tmux | tmux + xterm-256color | Set `t_8f/t_8b` escape codes manually before `colorscheme` |
| YCM go-completer | Go >=1.26 | Skip (old x/tools won't build); rely on ALE's gopls for Go completion |
| Go path | `/usr/local/go/bin` exists | Prepend to PATH (official tarball install location) |

### Branch Strategy

- **master**: Targets Ubuntu 24.04+ / Debian 12+ / Fedora 38+ and newer systems. Assumes all toolchain versions are sufficient.
- **Ubuntu-2204**: Targets Ubuntu 22.04 / Debian 11 and older systems. Includes version detection and fallback logic.
- **Merge principle**: Keep master clean. Compatibility adaptations are validated in Ubuntu-2204 before considering backport.

## Non-Functional Requirements

- **NFR1 — Fast startup**: YCM delayed loading, ALE lint delay (500ms)
- **NFR2 — No pollution**: tags in `~/.cache/tags`, plugins in `~/.vim/`
- **NFR3 — Safe updates**: plugin rollback on Vim startup failure
- **NFR4 — Portable**: bash script, standard apt packages, no exotic dependencies
- **NFR5 — Readable config**: modular vimrc, one file per feature

## Dependencies

| Component | Source |
|---|---|
| vim-plug | junegunn/vim-plug |
| YouCompleteMe | ycm-core/YouCompleteMe |
| ALE | dense-analysis/ale |
| LeaderF | Yggdroot/LeaderF |
| fzf | junegunn/fzf |
| fzf.vim | junegunn/fzf.vim |
| vim-autoformat | chiel92/vim-autoformat |
| asyncrun.vim | skywind3000/asyncrun.vim |
| vim-fugitive | tpope/vim-fugitive |
| vim-signify | mhinz/vim-signify |
| vim-airline | vim-airline/vim-airline |
| vim-gutentags | ludovicchabant/vim-gutentags |
| echodoc | Shougo/echodoc.vim |
| vim-prettier | prettier/vim-prettier |
| dirvish | justinmk/vim-dirvish |
| tmux-powerline | erikw/tmux-powerline |
| Color schemes | morhetz/gruvbox, arcticicestudio/nord-vim, sonph/onehalf |

## Open Questions

1. Neovim migration timeline? YCM supports NVIM but many ALE features work better there
2. Should we add copilot for AI completion?
3. Rust/C# language support?
4. VS Code Remote SSH / Codespaces compatibility?
