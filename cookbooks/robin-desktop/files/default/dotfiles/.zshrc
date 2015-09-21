# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git, knife, colored-man)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/opt/chefdk/bin/:/home/robin/scripts:/opt/curl/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/node-v0.10.30:/usr/local/go/bin:/home/robin/.cabal/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

export SHELL="/usr/bin/zsh"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias pstop="kill -STOP"
alias prun="kill -CONT"
alias jjq="jq"

export LESSOPEN="| source-highlight -f esc -s bash -oSTDOUT -i %s"
export LESS=" -R"

export DISABLE_AUTO_TITLE='true'

source tmuxp.zsh

# Takes a list of hostnames and creates a tmux session with them all open.
function muxer {

    if [[ $# == 0 ]]; then
        echo "Usage: muxer hostname [hostname] ..."
        return;
    fi;

    command="tmux ";
    first_go="yes";
    for x; do
        a=$(echo "$x" | tr "." " " | awk '{print $1}');
        if [[ "$first_go" == "yes" ]]; then
            first_go="no";
            command="$command new-session "
        else
            command="$command new-window "
        fi
         command="$command -d -n '$a' 'ssh $x'\;"
    done;
    command="$command attach\;"
    eval ${command};
}

function cfind {
    find $* -exec ls --color -d {} \;
}

function rs {
   knife search node "role:*$1* AND chef_environment:*$2*" -c ~/.chef/knife-prod;
}

function rsi {
   knife search node "role:*$1* AND chef_environment:*$2*" -i -c ~/.chef/knife-prod;
}

function strstaging {
   curl https://stream.stagingdatasift.com/93558e17de15072fa126370c37c5bd8f -H 'Auth: rsr5:f6fb4aaaf3e41d4b7e58f059dca51eec'
}

encForAllOps()
{
        gpg --output $1.pgp --encrypt --armour --recipient alex@mediasift.com --recipient robin.ridler@datasift.com --recipient gareth@datasift.com --recipient andrew.murphy@datasift.com --recipient marcin.cabaj@datasift.com --recipient stephen.brown@datasift.com --recipient alessio.martorelli@datasift.com $1
}
 
 
alias gpgallops=encForAllOps

