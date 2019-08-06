#!/usr/bin/env bash

set -u

# validate args
if [[ $# -eq 0 ]] ; then
    echo "requires at least 1 arg"
    echo "1: required --zsh | --bash | --skip-shell"
    echo "2: optional --install-devtools"
    exit 1
fi

if [ "$1" = "--skip-shell" ]; then
    echo "Skipping shell installation"
fi

##############################################
if [ "$1" = "--bash" ]; then
    echo "Setting up Bash"

    # backup bashrc
    mv ~/.bashrc ~/.bashrc.orig

    # symlink bashrc
    ln -sv ~/code/dotfiles/dotflies/bash/.bashrc_default ~/.bashrc_default
    ln -sv ~/code/dotfiles/dotflies/bash/.bashrc ~/.bashrc

    # add aliases
    ln -sv ~/code/dotfiles/dotflies/common/.aliases ~/.aliases
fi

##############################################
if [ "$1" = "--zsh" ]; then
    # echo "Setting up ZSH"

    # add zsh
    # sudo apt install zsh -y

    # add aliases
    # ln -sv ~/code/dotfiles/dotflies/common/.aliases ~/.aliases
    
    # install oh-my-zsh
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # change default shell
    # chsh -s "$(command -v zsh)"

    # install zgen
    # sudo apt install git -y
    # git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

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

if [ -z "$1" ]; then
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
    
fi

##############################################
### development tools
if [ -z "$2" ]; then
    echo "Skipping dev-tool installation"
fi

if [ "$2" = "--install-devtools" ]; then
    echo "Setting up development tooling"

    sudo apt install git curl automake autoconf libreadline-dev libncurses-dev \
    libssl-dev libyaml-dev libxslt-dev libffi-dev libtool unixodbc-dev -y

    ### asdf
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf
    if cd ~/.asdf; then
        git checkout "$(git describe --abbrev=0 --tags)";
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

    ### ruby
    # asdf plugin-add ruby
    # asdf install ruby 2.5.3
    # asdf global ruby 2.5.3

    ### golang
    # asdf plugin-add golang
    # asdf install golang 1.11.3
    # asdf global golang 1.11.3

    ### ocaml
    asdf plugin-add ocaml
    asdf install ocaml 4.07.0
    asdf global ocaml 4.07.0

    ### rust
    # asdf plugin-add rust
    # asdf install rust 1.31.0
    # asdf global rust 1.31.0

    # global node package
    # t-get for command line torrents
    npm install -g t-get
    
fi

### Ubuntu specific
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    ### GCloud
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get install apt-transport-https ca-certificates -y
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
    sudo apt-get update && sudo apt-get install google-cloud-sdk -y

    ### exfat support
    sudo apt-get install exfat-fuse exfat-utils -y

    ### increase max watchers
    echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p

    ### terminal Atom-One Light/Dark profiles
    # bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"
    # bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-light.sh)"

    ### add chrome gnome shell integration
    # sudo apt-get install chrome-gnome-shell -y

    # make zsh default
    chsh -s /usr/bin/zsh root
fi
