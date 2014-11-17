# Path to your oh-my-zsh configuration.
ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="candy"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git command-not-found python pip)
plugins=(git svn python)

source ${ZSH}/oh-my-zsh.sh

# Customize to your needs...

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sy/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


# required for Maven builds
JDK_LATEST=/usr/java/jdk_latest
JDK_LATEST=/usr/lib/jvm/jdk1.7.0_72
export JAVA_HOME=${JDK_LATEST}

PATHDIRS=(
    .
    ${JAVA_HOME}
    /export/SIE/tools/titanium/LATEST
    /export/SIE/tools/maven/LATEST/bin
    /usr/sbin
    ${HOME}/svn/trunk/Tools/build
    ${HOME}/cvs/Tools
    ${HOME}/dev/Puppet/puppet-scripts
    /opt/csw/bin
    /usr/lib/git-core
    /usr/share/doc/git-svn
    )

    for dir in ${PATHDIRS}; do
        if [ -d ${dir} ]; then
            path+=${dir}
        fi
    done

export http_proxy=http://www-proxy.us.oracle.com:80

# switch to emacs from vi on the cmdline
# various REPLs I use, use emacs keybindings
export EDITOR="emacs"
bindkey -e

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# source in aliases
source ${HOME}/.aliases

# ls -G is not supported on Solaris
if [ $(uname -s) = 'SunOS' ]; then
    unalias ls
fi

# required for Python cx_Oracle module loading
#export LD_LIBRARY_PATH=/usr/local/instantclient
export ORACLE_BASE=/opt/oracle
#export ORACLE_HOME=/opt/oracle/instantclient_11_2
export ORACLE_HOME=/usr/lib/oracle/11.2/client
export TNS_ADMIN=/opt/oracle/network/admin
#export LD_LIBRARY_PATH=/opt/oracle/instantclient_11_2
export LD_LIBRARY_PATH=${ORACLE_HOME}/lib
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8

# OPAM configuration
. /home/sy/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
