# Manual Installation Guide

This is the step-by-step guide if you prefer to install everything manually
instead of using `install.sh`.

## System packages

```
sudo apt install universal-ctags fonts-powerline pipx \
    clang-format clang clangd cppcheck ripgrep \
    build-essential cmake python3-dev
sudo update-alternatives --set ctags /usr/bin/ctags-universal
```

## vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Deploy config files

```
mkdir -p ~/.vim
cp vimrc ~/.vimrc
cp -r config ~/.vim/config
cp -r ftplugin ~/.vim/ftplugin
cp -r ftdetect ~/.vim/ftdetect
mkdir -p ~/.vim/cache ~/.cache/tags
```

## FZF

```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-update-rc --all
```

> **Note:** `--no-update-rc` prevents the installer from modifying `~/.bashrc`.
> If you want key bindings and auto-completion in the shell, run without this flag.

## yapf (Python formatter)

```
pipx ensurepath
pipx install yapf
```

## CMake tools

```
pipx install cmake-language-server
pipx install cmakelint
pipx install cmake-format
```

> YCM auto-detects `cmake-language-server` for completion and diagnostics.
> ALE auto-detects `cmakelint` for linting.

## Vim plugins

Open Vim and run `:PlugInstall`, or:

```
vim +PlugInstall +qall
```

## YouCompleteMe

```
cd ~/.vim/plugged/YouCompleteMe
python3 install.py --clang-completer --ts-completer
```

| Flag | Language support |
|------|-----------------|
| `--clang-completer` | C / C++ |
| `--ts-completer` | JavaScript / TypeScript |
| (built-in) | Python (jedi) |

> **Note:** `--go-completer` is available for Go support but requires `go` to be
> installed first. Omit it if you don't use Go.
>
> `python-dev` no longer exists on modern Ubuntu; `python3-dev` is sufficient.

## LeaderF C extension

```
cd ~/.vim/plugged/LeaderF
bash install.sh
```

## vim-prettier

```
cd ~/.vim/plugged/vim-prettier
yarn install
```

## Fonts

vim-airline uses `g:airline_powerline_fonts = 1`. Without a Powerline-patched
font, statusline symbols will display as garbled characters.

### Option 1: apt (Debian/Ubuntu)

```
sudo apt install fonts-powerline
```

### Option 2: Nerd Font (recommended)

Nerd Fonts include Powerline symbols plus extra icons:

```
mkdir -p ~/.local/share/fonts
wget -O /tmp/FiraCode.zip \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip /tmp/FiraCode.zip -d ~/.local/share/fonts/
fc-cache -fv
```

Browse available fonts: https://www.nerdfonts.com

> After installing, set your terminal emulator to use the font
> (e.g. "FiraCode Nerd Font").
