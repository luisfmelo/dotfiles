#!/usr/bin/env bash

# new setup and
CWD=$(pwd)

EXT_DIR="$HOME/.my-extensions"

# Install zsh
curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
chsh -s $(which zsh)

# create code dir if it doesn't exist
if [ ! -d "$EXT_DIR" ]; then
    mkdir -p "$EXT_DIR"
fi

# Found Mac OSX
if [[ "$OSTYPE" == "darwin"* ]]; then
    # homebrew!
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # sudo rm -rf /Library/Developer/CommandLineTools
    # sudo xcode-select --install

    # then install things
    # ./brew.sh


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
    echo "NOT SUPPORTED"
    return 1
fi

cd "$CWD"

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


# Configure ZSH
###############################
# Get Theme
wget https://raw.githubusercontent.com/oskarkrawczyk/honukai-iterm/master/honukai.zsh-theme && mv honukai.zsh-theme ~/.oh-my-zsh/custom/themes/honukai.zsh-theme

# Get Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

###############################

# symlinks!
#   put/move git credentials into ~/.gitconfig.local
#   http://stackoverflow.com/a/13615531/89484
# ./createSymLinks.sh  THIS IS NOT WORKING PROPERLY I DO NOT KNOW WHY


# Create Symlinks
###############################
current_time=$(date "+%Y.%m.%d-%H.%M.%S")

mv ~/.zshrc ~/.zshrc.old."$current_time"
ln -s ~/dotfiles/.zshrc ~/.zshrc

mv ~/.ssh/config ~/.ssh/config.old."$current_time"
ln -s ~/dotfiles/.ssh-config ~/.ssh/config
###############################