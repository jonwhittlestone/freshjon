#!/usr/bin/env bash
alias uua='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y'
set -u
#############################################
# 1. Linux Quality of Life Apps & Packages  #
#############################################
if [ "$1" = "--step1" ]; then
    snaps=(
        bitwarden, chromium, plexmediaserver
        wavebox
    )

    for t in ${snaps[@]}; do
        sudo snap install $t
    done
    # And then vscode with the flag
    sudo snap install code --classic

    uua
fi
###############################################
# 2. Shell and Dotfiles                       #
###############################################
if [ "$1" = "--step2" ]; then
 echo "Setting up ZSH"
    # add zsh
    sudo apt install zsh -y
    
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # change default shell
    chsh -s "$(command -v zsh)"

    # install zgen
    sudo apt install git -y
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

    # backup zshrc
    # mv ~/.zshrc ~/.zshrc.orig

    # symlink zshrc
    # ln -sv ~/code/dotfiles/dotflies/zsh/.zshrc_default ~/.zshrc_default
    # ln -sv ~/code/dotfiles/dotflies/zsh/.zshrc ~/.zshrc

    # add fonts for powerline
    sudo apt-get install fonts-powerline -y
    cd ~ && git clone https://github.com/powerline/fonts.git --depth=1
    fonts/install.sh
    cd ~ && rm -rf fonts/
fi
###############################################
# 3. Dev-specific Languages, Libraries, Apps  #
###############################################
if [ "$1" = "--step3" ]; then
    echo "Installing git, curl, z, fzf, shellcheck, neovim"

    ### prepare
    sudo apt install git curl -y

    ### z
    cd ~ && wget https://raw.githubusercontent.com/rupa/z/master/z.sh

    ### fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-zsh

    ### shellcheck
    sudo apt install shellcheck -y

    ### neovim
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update
    sudo apt-get install neovim -y

    sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
    sudo update-alternatives --config vi
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
    sudo update-alternatives --config vim
    sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
    sudo update-alternatives --config editor


    ### development tools
    sudo apt install git curl automake autoconf libreadline-dev libncurses-dev \
    libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev -y

    ### asdf - runtime versions
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    if cd ~/.asdf; then
        git checkout "$(git describe --abbrev=0 --tags)";
    else
        echo "ERROR accessing ~/.asdf dir. Possible error while cloning."
        echo "Try the following command manually:"
        echo "git clone https://github.com/asdf-vm/asdf.git ~/.asdf"
        exit
    fi

    uua
fi
#################################################
# 4. Simple 'browserstart' app for bookmarks   #
#################################################
if [ "$1" = "--step4" ]; then
    # See:
    # https://gist.github.com/funzoneq/737cd5316e525c388d51877fb7f542de#gistcomment-2306584

    sudo cp ~/code/freshjon/browserstart/etc/systemd/system/simplehttp.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl restart simplehttp.service

    # systemctl restart simplehttp.service
    # lsof -i:3000
fi