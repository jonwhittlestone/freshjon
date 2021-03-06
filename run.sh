#!/usr/bin/env bash
alias uua='sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y'
set -u
#############################################
# 1. Linux Quality of Life Apps & Packages  #
#############################################
if [ "$1" = "--step1" ] || [ "$1" = "--all" ]; then

    if [ "$1" = "--all" ]; then
        echo "** Running freshjon provisioner, run.sh all steps **"
        sleep 3
    fi
    # flatpak app store
    sudo add-apt-repository ppa:alexlarsson/flatpak
    sudo apt update
    sudo apt install flatpak -y
    sudo apt install gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # floiate ebook eader
    flatpak install flathub com.github.johnfactotum.Foliate -y

    # snaps
    snaps=(
        bitwarden, chromium, plexmediaserver
        wavebox, postman, vlc, redis-desktop-manager
    )

    for t in ${snaps[@]}; do
        sudo snap install $t
    done
    # And then vscode with the flag
    sudo snap install code --classic

    # flameshot - screenshots
    sudo apt install flameshot -y

    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

fi
###############################################
# 2. Shell and Dotfiles                       #
###############################################
if [ "$1" = "--step2" ] || [ "$1" = "--all" ]; then
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

    # tmux, theme, plugins
    sudo apt install tmux -y
    git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    git clone https://github.com/tmux-plugins/tmux-resurrect ~/.tmux/plugins/tmux-resurrect
    # symlink to this repo's .tmux.conf
    ln -sv ~/code/freshjon/.tmux.conf ~/.tmux.conf


fi
###############################################
# 3. Dev-specific Languages, Libraries, Apps  #
###############################################
if [ "$1" = "--step3" ] || [ "$1" = "--all" ]; then
    echo "Installing git, curl, z, fzf, shellcheck, neovim, docker"

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
    libssl-dev libyaml-dev libxslt-dev libffi-dev libtool -y

    ### dev tools - for python/mssql
    sudo apt install unixodbc-dev freetds-dev freetds-bin tdsodbc -y

    ### dev tools - for python/postgres
    sudo apt install libpq-dev -y

    ### asdf - runtime versions
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    if cd ~/.asdf; then
        git checkout "$(git describe --abbrev=0 --tags)";

        echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
        echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
        source ~/.zshrc

    else
        echo "ERROR accessing ~/.asdf dir. Possible error while cloning."
        echo "Try the following command manually:"
        echo "git clone https://github.com/asdf-vm/asdf.git ~/.asdf"
        exit
    fi
    

    ### nodejs
    asdf plugin-add nodejs
    bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
    asdf install nodejs 8.16.0
    asdf install nodejs 10.16.0
    asdf global nodejs 10.16.0

    ### yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt remove cmdtest -y
    sudo apt-get update -y
    sudo apt-get install --no-install-recommends yarn -y

    ### python
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev python3-pip -y
    pip install python3-venv

    asdf plugin-add python
    asdf install python 2.7.16
    asdf install python 3.7.3
    asdf global python 3.7.3

    # pyenv

    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
    libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl

    curl https://pyenv.run | bash
    echo 'PATH="/home/jon/.pyenv/bin:$PATH"' >> ~/.zshrc
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv install --list | grep " 3\.[678]"


    ### golang
    asdf plugin-add golang
    asdf install golang 1.11.3
    asdf global golang 1.11.3

    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

    ### docker, without sudo.
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    sudo apt install docker-ce -y
    sudo systemctl status docker
    sudo usermod -aG docker ${USER}
    su - ${USER}
    id -nG

    ### docker-compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose


    ### stacer monitoring
    sudo add-apt-repository ppa:oguzhaninan/stacer -y
    sudo apt-get update
    sudo apt-get install stacer -y

    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y

fi
#################################################
# 4. Quality of life software
#   eg. Simple 'browserstart' app for bookmarks   
#       wallpaper etc
#################################################
if [ "$1" = "--step4" ] || [ "$1" = "--all" ]; then
    ### Browser start at http://localhost:3000:
    # see: https://gist.github.com/funzoneq/737cd5316e525c388d51877fb7f542de#gistcomment-2306584

    sudo cp ~/code/freshjon/browserstart/etc/systemd/system/simplehttp.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl restart simplehttp.service

    # systemctl restart simplehttp.service
    # lsof -i:3000

    ### Jupyter Notebook & vim keybindings
    pip install jupyter
    mkdir -p $(jupyter --data-dir)/nbextensions
    cd $(jupyter --data-dir)/nbextensions
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
    jupyter nbextension enable vim_binding/vim_binding

    ### Virtualbox - see: https://tinyurl.com/y2bdqxhw
    wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
    echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
    sudo apt update
    sudo apt-get -y install virtualbox-6.0

    ### speedtest-cli
    pip install speedtest-cli

    # variety wallpapers: https://github.com/varietywalls/variety
    sudo apt install variety

    # tree: directory listing
    sudo apt install tree

    # geekbench benchmarking
    wget http://cdn.geekbench.com/Geekbench-5.0.1-Linux.tar.gz
    echo 'Todo. Uncompress and run Geekbench'

    # bat - A cat(1) clone with wings
    wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat-musl_0.12.1_amd64.deb
    sudo dpkg -i bat-musl_0.12.1_amd64.deb 

    

fi
