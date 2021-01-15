# ~/.zshrc
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path for SonarQube & SunarScanner
export PATH=$PATH:~/Downloads/SonarScanner/bin
export PATH=$PATH:~/Downloads/SonarQube/bin

# Path for python cli applications (using pipx)
export PATH=$PATH:/Users/luismelo/.local/bin

# Path for Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=${PATH}:$GOBIN

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="honukai"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # produtivity
  colored-man-pages colorize copydir copyfile cp extract history sudo urltools web-search z

  # programming
  git node npm kubectl docker dotenv golang django python

  # ZSH
  zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
)

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

##################
# ALIAS
##################
alias hs='history | grep'
alias myip="curl http://ipecho.net/plain; echo"
alias ctrlc='xclip -selection clipboard -i'
alias ctrlv='xclip -selection clipboard -o'
alias genpass='f(){date +%s | sha256sum | base64 | head -c $1 ; echo}; f' . # Ex: $ genpass 32 -> will generate a random 32 chars password

# Git aliases
alias git-config="code ~/.gitconfig"

# Package manager aliases
alias update-apps="sudo apt -ym update && sudo apt -ym upgrade && sudo apt -ymf install --no-install-recommends"
alias clean="sudo apt -y autoremove --purge && sudo apt -y autoclean && sudo apt -y clean && sudo rm -rf /var/crash"
alias update-pip="pip2 freeze | cut -d= -f1 | xargs sudo -H pip2 install --upgrade --no-cache-dir && pip3 freeze | cut -d= -f1 | xargs sudo -H pip3 install --upgrade --no-cache-dir"
alias update="update-apps && update-pip && ohmyzsh-update && clean"

# Development aliases
alias g="git"
alias sqlite3="sqlite3 -header -column"
alias mkvenv="virtualenv -p \$(which python3) venv && source venv/bin/activate"
alias venvon="source venv/bin/activate"
alias venvoff="deactivate"

# System aliases
alias sudo="nocorrect sudo"
alias xclip="xclip -selection clipboard"
alias ip:local="hostname -I | cut -d' ' -f1"
alias ip:public="wget https://ipinfo.io/ip -qO -"

# SonarQube & SonarScanner
alias sonarqube="~/Downloads/SonarQube/bin/macosx-universal-64/sonar.sh"
alias sonarscanner="~/Downloads/SonarScanner/bin/sonar-scanner"

##################
# Functions
##################
function cd {
   builtin cd $@ && ls
}

function open {
   for file in $@; do
       xdg-open $file
   done 1> /dev/null 2> /dev/null
}

# We can use this function as curl to evaluate performance of a given request
function perf {
  curl -o /dev/null -s -w "Time to connect: %{time_connect} s\nRequest duration: %{time_starttransfer} s\nTotal Time: %{time_total} s\n" "$1"
}

pdfcompress ()
{
   gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile=$1.compressed.pdf $1;
}


decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'='
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode_jwt(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

# Decode JWT Payload
alias jwt-decode="decode_jwt 2"

alias addkey='eval $(ssh-agent) && ssh-add'

# source $ZSH/oh-my-zsh.sh