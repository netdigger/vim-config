# vim-config
The vim config for IDE of C/C++ python golang

#user manual

## install ctags
### Linux
    sudo apt install exuberant-ctags
### Mac Os
    
## Install Vundle

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    
## install vim-config

    wget https://raw.githubusercontent.com/netdigger/vim-config/master/.vimrc ~/

# install plugins
if you can access https://golang.org, you can do that:
Start vim, and run:

    :BundleInstall
    :GoInstallBinaries

## intall YouComplete me

Please refer the [Install Guide](https://github.com/Valloric/YouCompleteMe)

if you want change the color of auto complete menu, please refer the web page:
[Colors](https://jonasjacek.github.io/colors/)

# For users behind GFW
if you can't access the site, you should do follow these steps:

start vim, and run command in vim:

    :BundleInstall
    
run command in shell:
    
    $ sed -i 's|golang.org/x|github.com/golang|g' ~/.vim/bundle/vim-go/plugin/go.vim
    
run command in vim:

    :GoInstallBinaries
    
it will download tools vim-go needs and install. this step will continue long time.
And we will <font color=red>**get error informations**</font> while installing some tools. 
Don't worry about it, because we changed source path of these tools, and don't change the source code. 
We will fix the problem in next step. 

Note: <font color=red>**before next step, you should remove all yourself project in GOPATH.**</font>
run command in shell:

    $ find $GOPATH -type f -name "*.go" -exec sed -i "s|golang.org/x|github.com/golang|g" {} \;
    
run command in Vim:

    :GoInstallBinaries
