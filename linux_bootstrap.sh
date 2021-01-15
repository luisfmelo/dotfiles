if ! [ "$(id -u)" = 0  ]; then
    APTCMD="sudo apt-get"
else
    APTCMD="apt-get"
fi

# Update & Upgrade
eval "$APTCMD" update -y
eval "$APTCMD" upgrade -y
eval "$APTCMD" dist-upgrade -y

# Install apps
eval "$APTCMD" install \
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
    software-properties-common \
    python-dev \
    python-setuptools \
    python-pip \
    python3-dev \
    python3-setuptools \
    python3-pip \
    silversearcher-ag \
    vim-nox \
    zsh \
    powerline \
    fonts-powerline \
    terminator \
    xclip \
    -y --reinstall

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}
su ${USER}
id -nG
sudo apt-get install docker-compose -y

# Update & Upgrade
eval "$APTCMD" update -y
eval "$APTCMD" upgrade -y
eval "$APTCMD" dist-upgrade -y
eval "$APTCMD" autoclean -y
eval "$APTCMD" auto-remove -y

# configure #!/usr/bin/env
[ -d "~/.zshrc.old" ] || rm ~/.zshrc.old
cp ~/.zshrc ~/.zshrc.old
cp ~/dotfiles/.zshrc ~/.zshrc

# Adding Oh my #!/usr/bin/env zsh
[ ! -d "~/oh-my-zsh" ] || sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Restart machine
read -p "Restart the machine to apply changes? [y/N]:" RESTART
# condition for specific letter
if [ "${RESTART}" == "y" || "${RESTART}" == "Y" ] ; then
  echo "Restarting..."
  restart
else
  echo "Finished!"
fi
