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
| Go             | YCM + gopls      | ALE (gopls, golangci-lint)| goimports     |
| Octave/Matlab  | —                | —                    | —             |

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
│   ├── signify.vimrc         ← git diff signs
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
