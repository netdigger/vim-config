# vim-config

The vim config for IDE of C/C++, Python, Go, JavaScript, and TypeScript.

## Quick Install

```bash
git clone https://github.com/netdigger/vim-config.git ~/vim-config
bash ~/vim-config/install.sh
```

`install.sh` deploys everything into `~/.vim/` — no symlinks, fully self-contained.
It is safe to run multiple times (all steps are idempotent). Run it again after
`git pull` to update.

> For step-by-step instructions, see [INSTALL.md](INSTALL.md).

## Language support

| Language       | Completion       | Linting              | Formatting    |
|----------------|------------------|----------------------|---------------|
| C / C++        | YCM + clangd     | ALE (clang, cppcheck)| clang-format  |
| Python         | YCM (jedi)       | ALE                  | yapf          |
| JavaScript/TS  | YCM (tsserver)   | ALE                  | prettier      |
| CMake          | YCM (cmake-ls)   | ALE (cmakelint)       | cmake-format  |
| Go             | YCM + gopls      | ALE (gopls, golangci-lint)| goimports     |
| Octave/Matlab  | —                | —                    | —             |

## Keybindings

Leader key: <kbd>Space</kbd>

### Window / Terminal

| Key | Action |
|-----|--------|
| `Ctrl-h/j/k/l` | Move to left/down/up/right window |
| `<Space>w` | Open vertical terminal (65 cols) |
| `<Space>W` | Open horizontal terminal (15 rows) |
| `<Esc><Esc>` (terminal) | Switch to Terminal-Normal mode |
| `<Space>tc` (terminal) | Close terminal window |
### File / Symbol / Buffer

| Key | Action |
|-----|--------|
| `<Space>o` | FZF — fuzzy file finder |
| `<Space>m` | LeaderF — most recently used files |
| `<Space>f` | LeaderF — functions in current file |
| `<Space>b` | LeaderF — open buffers |
| `<Space>t` | LeaderF — project tags |
| `<Space>l` | LeaderF — lines in current file |

### Git

| Key | Action | Plugin |
|-----|--------|--------|
| `<Space>g` | Git status (stage/unstage with `s`, diff with `dd`) | Fugitive |
| `<Space>gb` | Git blame | Fugitive |
| `<Space>gd` | Diff current file | Signify |
| `<Space>gc` | Git commit | Fugitive |
| `<Space>gp` | Git push | Fugitive |
| `<Space>gl` | Git pull | Fugitive |
| `<Space>gr` | Git log (current file) | Fugitive |
| `<Space>gR` | Git log (all) | Fugitive |

### Formatting

| Key | File type | Action |
|-----|-----------|--------|
| `<Space>i` | C / C++ | clang-format (Google style) |
| `<Space>i` | Python | yapf |
| `<Space>i` | JavaScript / TS / JSX / TSX | Prettier |
| `<Space>i` | CMake | cmake-format |
| `<Space>i` | Other | Autoformat (auto-detect) |

### Build / Run / Test (filetype-specific)

| Key | C / C++ | Go | CMake |
|-----|---------|-----|-------|
| `<F5>` | — | `go run %` | Config + build |
| `<F6>` | `make clean` | — | — |
| `<F7>` | `make` | `go build ./...` | `cmake --build build` |
| `<F11>` | `make test` | `go test ./...` | `ctest` |

### Quickfix

| Key | Action |
|-----|--------|
| `<F8>` | Next error / location |
| `<F9>` | Previous error / location |
| `<F10>` | Close quickfix window |

### Insert Mode

| Key | Action |
|-----|--------|
| `Ctrl-t` | Insert ISO 8601 timestamp |


## Project structure

```
vim-config/
├── vimrc                     ← global settings, sources all configs
├── install.sh                ← one-command installer
├── INSTALL.md                ← manual install guide
├── config/                   ← plugin settings
│   ├── plug_plugins.vimrc    ← plugin list (vim-plug)
│   ├── ale.vimrc             ← linting
│   ├── ycm.vimrc             ← completion
│   ├── airline.vimrc         ← statusline
│   ├── git.vimrc             ← Git (fugitive + signify)
│   ├── gutentags.vimrc       ← ctags management
│   ├── leaderf.vimrc         ← file / tag / function navigation
│   ├── fzf.vimrc             ← fuzzy finder
│   ├── asyncrun.vimrc        ← async build
│   ├── echodoc.vimrc         ← command-line echo
│   ├── autoformat.vimrc      ← code formatting
│   └── go.vimrc              ← Go plugin settings
├── ftplugin/                 ← per-filetype settings
│   ├── c.vim                 ← C / C++
│   ├── python.vim            ← Python
│   ├── cmake.vim              ← CMake
│   ├── go.vim                ← Go
│   ├── javascript.vim        ← JavaScript
│   ├── javascriptreact.vim   ← JSX / React
│   ├── typescript.vim        ← TypeScript
│   └── typescriptreact.vim   ← TSX / React
└── ftdetect/                 ← filetype detection
    └── octave.vim            ← Octave / Matlab
```

Deployed to:

```
~/.vim/
├── config/          ← copied from repo config/
├── ftplugin/        ← copied from repo ftplugin/
├── ftdetect/        ← copied from repo ftdetect/
├── plugged/         ← plugins (managed by vim-plug)
└── autoload/
    └── plug.vim     ← vim-plug
```
