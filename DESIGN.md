# Design Document: dev-env Terminal Development Environment

## Architecture Overview

```
dev-env/
├── install.sh              # Installation orchestrator (bash)
├── README.md               # User documentation
├── INSTALL.md              # Manual install guide
├── Requirements.md          # Product requirements document
├── DESIGN.md               # This document
│
├── vim/                    # Vim configuration
│   ├── vimrc               # Entry point: global settings + sources all modules
│   ├── config/             # Plugin-level configs (14 independent vimrc files)
│   │   ├── plug_plugins.vimrc   # Plugin list (vim-plug)
│   │   ├── airline.vimrc        # Statusline
│   │   ├── ale.vimrc            # Linting
│   │   ├── ycm.vimrc            # Completion
│   │   ├── git.vimrc            # Git integration
│   │   ├── gutentags.vimrc      # Ctags management
│   │   ├── leaderf.vimrc        # Navigation/search
│   │   ├── fzf.vimrc            # Fuzzy search
│   │   ├── terminal.vimrc       # Terminal window + cursor shape
│   │   ├── asyncrun.vimrc       # Async execution
│   │   ├── echodoc.vimrc        # Command echo
│   │   ├── autoformat.vimrc     # Code formatting
│   │   └── go.vimrc             # Go-specific
│   ├── ftplugin/           # Loaded by filetype
│   │   ├── c.vim            # C/C++
│   │   ├── python.vim       # Python
│   │   ├── cmake.vim        # CMake
│   │   ├── go.vim           # Go
│   │   ├── javascript.vim   # JavaScript
│   │   ├── typescript.vim   # TypeScript
│   │   ├── javascriptreact.vim   # JSX
│   │   ├── typescriptreact.vim   # TSX
│   │   └── octave.vim       # Octave/Matlab
│   └── ftdetect/           # Filetype detection
│       └── octave.vim
│
└── tmux/                   # tmux configuration
    ├── tmux.conf           # Main configuration
    ├── powerline-theme.sh  # Statusbar theme
    └── README.md
```

## Design Decisions

### D1 — Why vim-plug over native pack or other managers?

- Fastest loading: all plugins are lazy-loaded until `call plug#end()`
- Declarative: plugin list separated from config (`plug_plugins.vimrc` + `config/*.vimrc`)
- Mature ecosystem: `{'do': '...'}` post-update hooks

**Alternative**: native `:pack add` — manual lazy-load configuration, fewer plugins.

### D2 — Why YCM over LSP/native-lsp?

- YCM provides the most complete completion experience in Vim (index-driven, no LSP server dependency)
- ALE handles linting and optional LSP completion simultaneously, forming two layers of checks
- Compiled languages (C/C++) are sensitive to LSP index quality; YCM's `.ycm_extra_conf.py` is more stable

**Trade-off**: YCM compilation takes longer (via `python3 install.py` in the installer), startup is slower than LSP. But configuration is simpler — no need to manage multiple LSP server processes.

### D3 — Why ALE over vim-lsc/vim-lsp?

- Zero-configuration: auto-detects available linters in the project, no per-language server config needed
- Asynchronous execution, does not block editing
- Three feedback modes: gutter sign + statusline + quickfix
- Manual linter switching supported via `g:ale_linters` (e.g., use g++ for C++ instead of clang)

### D4 — Modular vimrc Design

```
vimrc (entry point)
  ├── plug_plugins.vimrc   ← must be sourced first, defines plugin list
  ├── [runtime settings]     ← global settings
  ├── terminal.vimrc       ← terminal toggle + cursor shape
  ├── git.vimrc            ← keybindings
  ├── asyncrun.vimrc       ← shortcuts
  ├── gutentags.vimrc      ← ctags cache
  ├── ale.vimrc            ← lint rules
  ├── leaderf.vimrc        ← navigation/search
  ├── fzf.vimrc            ← FZF layout
  ├── ycm.vimrc            ← completion options
  ├── airline.vimrc        ← statusbar
  ├── echodoc.vimrc        ← command echo
  └── go.vimrc + autoformat.vimrc  ← language-specific (sourced last)
```

**Design principles**:
- Each file handles one plugin/feature domain, < 60 lines
- vimrc is the entry point, only responsible for source order, no config logic
- `ftplugin/` files are auto-loaded via filetype plugin mechanism, no vimrc references needed

### D5 — Installer Script Architecture

```
install.sh
  ├── install_packages()     ← system packages + tooling (idempotent)
  │   ├── apt package check  ← dpkg -s
  │   ├── fzf install        ← git clone + install script
  │   ├── gopls              ← go install
  │   ├── yapf               ← pipx install
  │   └── cmake tools        ← pipx install
  │
  ├── configure_vim()        ← Vim config deployment
  │   ├── vim-plug install   ← curl download plug.vim
  │   ├── file copy          ← cp to ~/.vim/
  │   ├── plugin snapshot    ← git rev-parse HEAD
  │   ├── PlugUpdate         ← install/update plugins
  │   ├── startup test       ← vim -c quit
  │   ├── rollback           ← git checkout snapshot on failure
  │   ├── YCM compilation    ← python3 install.py
  │   ├── LeaderF C extension← bash install.sh
  │   └── vim-prettier deps  ← yarn/npm install
  │
  └── configure_tmux()       ← tmux config deployment
      ├── tmux-powerline    ← git clone
      └── file copy         ← ~/.tmux.conf + theme
```

**Key design**:
- Idempotency: all steps check existence first, skip if present
- Safe updates: plugin snapshot + test + rollback in three steps to prevent broken environment on reinstall
- Partial install: supports `install.sh vim` / `install.sh pkg` modes

### D6 — tmux Configuration Design

```
tmux.conf
  ├── prefix key            ← unbind C-b, use C-j (double-tap to pass through)
  ├── basic settings        ← 256 colors, mouse, history, vi keys
  ├── statusbar             ← driven by tmux-powerline script
  ├── copy mode            ← vi key bindings
  ├── pane operations      ← | / - split, h/j/k/l navigate
  ├── popup terminal        ← display-popup
  ├── synchronize input    ← e/E toggle
  └── quick reload          ← C-r source-file
```

**Why Ctrl-j as prefix**:
- Consistent with Vim window navigation C-h/j/k/l, reduces cognitive load
- Double-tap passthrough: `bind-key C-j send-prefix` allows passing C-j when needed

### D7 — Filetype Plugin System

```
vim/ftplugin/
  ├── c.vim       ← cindent + cinoptions + F6/F7/F11 build + 80-col highlight
  ├── cmake.vim   ← 2-space indent + cmake build commands
  ├── go.vim      ← go run/build/test + F5/F7/F11
  ├── python.vim  ← 4-space tab
  ├── javascript.vim   ← Prettier formatting
  ├── typescript.vim   ← Prettier formatting
  ├── javascriptreact.vim  ← Prettier formatting
  └── typescriptreact.vim  ← Prettier formatting
```

**Loading mechanism**:
- `filetype plugin indent on` enabled in vimrc
- vim auto-matches `ftplugin/` files by file extension
- `ftdetect/` provides detection for files without standard extensions (e.g., Octave)

### D8 — Formatting Architecture

```
vim-autoformat (unified framework)
  ├── clangformat     ← prefer project .clang-format if present, else Google style
  │   ├── auto-detect shiftwidth/textwidth/expandtab for style
  │   └── fallback: BasedOnStyle: Google
  ├── yapf            ← Google style
  ├── prettier        ← project-level .prettierrc
  └── cmake-format    ← default config
```

**clang-format intelligent fallback**:
- Prefer project root `.clang-format`
- If absent, dynamically generate style string translating vim settings (shiftwidth, textwidth, expandtab) to clang-format options

## Data Flow

### Build Flow

```
User presses F7
  ↓
AsyncRun executes make / go build / cmake --build in background
  ↓
Output to quickfix window (close with F10)
  ↓
ALE async lint (auto-triggered during editing)
  ↓
gutter sign + statusline display errors/warnings
```

### Completion Flow

```
User types character
  ↓
YCM index-driven completion (triggered at updatetime=300ms)
  ↓
echodoc displays current function signature
  ↓
Pmenu / PmenuSel custom highlighting
```

### Installation Flow

```
install.sh
  ↓
install_packages() → dpkg check → apt install
  ↓
configure_vim() → vim-plug install → file copy
  ↓
Plugin snapshot → PlugUpdate → vim -c quit test
  ↓ On failure
Rollback to snapshot version
  ↓
YCM compile → LeaderF C extension → prettier deps
  ↓
configure_tmux() → tmux-powerline → file copy
```

## Security Considerations

| Risk | Mitigation |
|---|---|
| Installer requires sudo | Explicitly prompts for `sudo apt install`, never silent |
| Plugin updates cause crashes | Snapshot + test + rollback three-step mechanism |
| curl download security | vim-plug uses GitHub raw, no MITM risk |
| pipx/go install network dependency | Network failures warn, never abort; manual handling allowed |

## Extension Points

| Direction | File to change |
|---|---|
| New language | `vim/ftplugin/<lang>.vim` + `vim/config/ale.vimrc` + add tools to `install.sh` |
| New lint rule | Add linter entry to `vim/config/ale.vimrc` |
| New keybinding | Add to `vim/config/<plugin>.vimrc` or `vimrc` |
| Switch to Neovim | `install.sh` adapt nvim path; YCM compile args change; some plugins replaced |
| Add AI completion | New `vim/config/copilot.vimrc` + add copilot to `plug_plugins.vimrc` |
