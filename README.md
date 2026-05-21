# vim-config

The vim config for IDE of C/C++, Python, Go, JavaScript, and TypeScript.

# User Manual

## Install ctags

### Linux

```
sudo apt install exuberant-ctags
```

## Install vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## Install vim-config

Clone the source code and link the vimrc.

```
git clone https://github.com/netdigger/vim-config.git ~/vim-config
ln -s ~/vim-config/vimrc ~/.vimrc
```

## Install code formatters

```
sudo apt install clang-format
sudo apt install yapf
```

## Install fonts of powerline

```
sudo apt install fonts-powerline
```

> **Note:** `powerline-status` (Python package) has been removed from the default
> install instructions. This config uses vim-airline which is a pure VimScript
> plugin and does not require the Python powerline daemon. Only the powerline
> fonts are needed for the statusline symbols.
>
> If you use the original vim-powerline plugin or need the powerline daemon,
> install it via apt: `sudo apt install powerline`

## Install FZF

Please refer to the FZF document: https://github.com/junegunn/fzf

## Install plugins

Start vim and run:

```
:PlugInstall
```

## Install YouCompleteMe

```
sudo apt install build-essential cmake
sudo apt install python-dev python3-dev
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer --go-completer
```

Please refer to the [Install Guide](https://github.com/ycm-core/YouCompleteMe)
for detailed information.

If you want to change the color of the auto complete menu,
please refer to: [Colors](https://jonasjacek.github.io/colors/)

## Install config for file types

Create links for all files in `ftplugin/` to `~/.vim/ftplugin`.

Example:

```bash
cd ~/.vim/ftplugin
ln -s ~/vim-config/ftplugin/typescript.vim typescript.vim
ln -s ~/vim-config/ftplugin/javascript.vim javascript.vim
```
