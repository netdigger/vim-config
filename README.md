# vim-config

The vim config for IDE of C/C++ python golang

# user manual

## install ctags

### Linux

sudo apt install exuberant-ctags

## Install vim-plug

         curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## install vim-config

Clone the source code to the home direcotry.

         git clone https://github.com/netdigger/vim-config.git ~/
         ln -s ~/vim-config/vim.rc .vimrc 

## Innstall code formatter

         sudo apt install clang-format exuberant-ctags
         suod apt install yapf

## Insall fonts of powerline

         sudo apt install fonts-powerline
         pip install powerline-status

## install FZF

Please reference FZF document: https://github.com/junegunn/fzf

# install plugins

You can do that: Start vim, and run:

         :PlugInstall

## intall YouComplete me

         sudo apt install build-essential cmake
         sudo apt install python-dev python3-dev
         cd ~/.vim/bundle/YouCompleteMe
         ./install.py --clang-completer --go-completer

Please refer the [Install Guide](https://github.com/Valloric/YouCompleteMe) 
for detail information

Ff you want change the color of auto complete menu, 
please refer the web page: [Colors](https://jonasjacek.github.io/colors/)

## Install config for file types 

Create links for all files in ftplug to .vim/ftplugin.

Example:

```bash
cd ~/.vim/ftplugin
ln -s ../vim-config/ftplugin/typescript.vim typescript.vim

```
