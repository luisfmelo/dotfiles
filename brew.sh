#!/usr/bin/env bash

# Install command-line tools using Homebrew

# Make sure we’re using the latest Homebrew
brew update
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated)
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install screen
brew install coreutils
brew install binutils
brew install findutils
brew install diffutils

brew install moreutils
brew install gnu-sed
brew install gnu-tar
brew install gawk
brew install gnutls
brew install grep
brew install screen
brew install watch
brew install wdiff


# Install Bash 4
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before running `chsh`.
brew install bash
brew install bash-completion

brew install grc
brew install wget

# Install other useful binaries
brew install the_silver_searcher
brew install git
brew install bzr
brew install pv
brew install rename
brew install tree
brew install git-tracker
brew install ssh-copy-id

# Install native apps
brew install homebrew/brew-cask
brew tap homebrew/cask-versions

# dev
brew install --cask iterm2
brew install tmux
brew install tree
brew install wget
brew install cmake
brew install autoconf
brew install telnet
brew install libevent
brew install ctags
brew install cscope
brew install go
brew install jq

# ssl, mongodb, redis and mysql
brew install openssl
brew link openssl
brew install redis

# docker
brew install --cask docker

# fun
brew install --cask vlc
brew install --cask spotify
brew install --cask slack
# brew install --cask franz
brew install --cask google-chrome
brew install --cask brave-browser

# add services command for easy stop/start of daemons
brew tap homebrew/services

# Fonts
brew tap homebrew/cask-fonts
fonts=(
	font-source-code-pro
	font-roboto
)
brew install --cask "${fonts[@]}"


# Remove outdated versions from the cellar
brew cleanup
brew doctor