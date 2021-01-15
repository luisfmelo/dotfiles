#!/usr/bin/env bash

# new setup and
CWD=$(pwd)

EXT_DIR="$HOME/.my-extensions"

# Install zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh; zsh

if ! [ "$(id -u)" = 0  ]; then
    INSTALLCMD="sudo apt-get install"
else
    INSTALLCMD="apt-get install"
fi

# create code dir if it doesn't exist
if [ ! -d "$EXT_DIR" ]; then
    mkdir -p "$EXT_DIR"
fi

# Found Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    # homebrew!
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    sudo rm -rf /Library/Developer/CommandLineTools
    sudo xcode-select --install

    # then install things
    ./brew.sh


    # github.com/thebitguru/play-button-itunes-patch
    # disable itunes opening on media keys
    git clone https://github.com/thebitguru/play-button-itunes-patch "$EXT_DIR"/play-button-itunes-patch

    # change to bash 4 (installed by homebrew)
    # BASHPATH=$(brew --prefix)/bin/bash
    # sudo echo "$BASHPATH" >> /etc/shells
    # chsh -s "$BASHPATH" # will set for current user only.
    # echo "Bash version is: (should be 4.x)"
    # echo "$BASH_VERSION" # should be 4.x not the old 3.2.X
    # Later, confirm iterm settings aren't conflicting.


elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    # Found Linux

    if [ -f /etc/lsb-release  ]; then
        # Found Ubuntu
        #. /etc/lsb-release

        # Add PPAs
        if [ "$(id -u)" = 0  ]; then
            add-apt-repository ppa:neovim-ppa/unstable -y
        else
            sudo add-apt-repository ppa:neovim-ppa/unstable -y
            sudo apt-get update
        fi

        # Install stuff
        eval "$INSTALLCMD" \
            bash-completion \
            build-essential \
            bzr \
            checkinstall \
            cmake \
            curl \
            exuberant-ctags \
            git \
            binutils \
            bison \
            gawk \
            gcc \
            grc \
            libc6-dev \
            libpcre3 \
            libpcre3-dev \
            libssl-dev \
            mercurial \
            neovim \
            nodejs \
            python-software-properties \
            python-dev \
            python-setuptools \
            python-pip \
            python3-dev \
            python3-setuptools \
            python3-pip \
            silversearcher-ag \
            vim-nox \
            -y --reinstall

    elif [ -f /etc/os-release  ]; then
        # Found Debian
        #. /etc/os-release

        # add add apt-repositories
        echo "deb http://ppa.launchpad.net/neovim-ppa/unstable/ubuntu vivid main" | sudo tee -a /etc/apt/sources.list > /dev/null
        sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 55F96FCF8231B6DD
        sudo apt-get update
        eval "$INSTALLCMD" software-properties-common -y

        # add PPAs
        if [ "$(id -u)" = 0  ]; then
            curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
        else
            curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
        fi

        # Install stuff
        sudo apt-get install \
            bash-completion \
            binutils \
            bison \
            build-essential \
            bzr \
            bzip2 \
            checkinstall \
            cmake \
            curl \
            exuberant-ctags \
            gawk \
            git \
            gcc \
            grc \
            libc6-dev \
            libpcre3 \
            libpcre3-dev \
            libssl-dev \
            mercurial \
            python-software-properties \
            python-dev \
            python-setuptools \
            python-pip \
            python3-dev \
            python3-setuptools \
            python3-pip \
            vim-nox \
            silversearcher-ag \
            -y --reinstall
    fi
fi

cd $CWD

# github.com/rupa/z   - oh how i love you
# git clone https://github.com/rupa/z.git "$EXT_DIR/z"
# chmod +x "$EXT_DIR/z/z.sh"
# consider reusing your current .z file if possible. it's painful to rebuild :)
# z hooked up in .bash_profile


# don't let ssh timeout locally
if [ -d "$HOME/.ssh" ]; then
    echo "ServerAliveInterval 120" >> "$HOME/.ssh/config"
    chmod 644 "$HOME/.ssh/config"
else
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo "ServerAliveInterval 120" >> "$HOME/.ssh/config"
    chmod 644 "$HOME/.ssh/config"
fi

# install patched fonts for vim statusline
git clone https://github.com/powerline/fonts "$EXT_DIR/fonts"
$EXT_DIR/fonts/install.sh

# for the c alias (syntax highlighted cat)
#sudo easy_install Pygments

# Configure SSH
###############################
# Personal keys
ssh-keygen -f "$CWD/../.ssh/id_rsa_github" -t rsa -b 4096 -C "luismelo7@gmail.com"
#ssh-keygen -f "$CWD/../.ssh/id_rsa_gitlab" -t rsa -b 4096 -C "name.gitlab@gmail.com"
#ssh-keygen -f "$CWD/../.ssh/id_rsa_bitbucket" -t rsa -b 4096 -C "name.bitbucket@gmail.com"

# Organization Keys
#ssh-keygen -f "$CWD/../.ssh/id_rsa_github_companyName" -t rsa -b 4096 -C "name.github@company.com"
#ssh-keygen -f "$CWD/../.ssh/id_rsa_gitlab_companyName" -t rsa -b 4096 -C "name.gitlab@company.com"
ssh-keygen -f "$CWD/../.ssh/id_rsa_bitbucket_kelvin" -t rsa -b 4096 -C "luis.melo@kelvininc.com"

# Add the personal keys
ssh-add $CWD/../.ssh/id_rsa_github
# ssh-add $CWD/../.ssh/id_rsa_gitlab
# ssh-add $CWD/../.ssh/id_rsa_bitbucket

# Add the organisation keys
# ssh-add $CWD/../.ssh/id_rsa_github_companyName
# ssh-add $CWD/../.ssh/id_rsa_gitlab_companyName
ssh-add $CWD/../.ssh/id_rsa_bitbucket_kelvin

###############################

# symlinks!
#   put/move git credentials into ~/.gitconfig.local
#   http://stackoverflow.com/a/13615531/89484
./createSymLinks.sh