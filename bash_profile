### Environment variables ###

export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/share/python:~/.local/bin:./bin:~:$PATH:."
export CDPATH=".:~:~/projects/personal:~/projects/sandbox"
export LANG="en_US.UTF-8"

export CLICOLOR=1
export TERM=xterm-256color
export LSCOLORS=DxGxcxdxCxegedabagacad

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

### Aliases ###

# Enable aliases to be sudo’ed
alias sudo="sudo "

# Easier navigation
alias ..="cd .."
alias ...="cd ../.."

alias c="clear"

# Bundler
alias b="bundle"
alias bi="b install --path vendor"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# Git
alias gadd="git add -u && git add . && git status -sb"
alias gpm="git pull --rebase origin master"

# system #
alias l="ls -lah"
alias tf="tail -f"
alias rehash="source ~/.bash_profile"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias df="df -h"
alias du="du -h"

alias less="less -r"                          # raw control characters
alias grep="egrep --color"                    # show differences in colour


if [[ $OSTYPE == darwin* ]]; then
  # Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
  alias update="sudo softwareupdate -i -a; brew update; brew upgrade"

  # Speed-up Terminal load time by clearing system logs
  alias speedup="sudo rm -rf /private/var/log/asl/*"

  # Empty the Trash on all mounted volumes and the main HDD
  # Also, clear Apple’s System Logs to improve shell startup speed
  alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; speedup"

  # IP addresses
  alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
  alias localip="ifconfig en0 inet | grep 'inet ' | awk ' { print $2 } '"
  alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
fi

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

### End Aliases ###


### Completions ###
if [[ $OSTYPE == darwin* ]]; then
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi
fi

COMPLETION="$HOME/.completion/*.bash"
for config_file in $COMPLETION
do
  source $config_file
done

### End Completions ###


### Misc Utilities ###

UTILITIES="$HOME/.bash_utilities/*.bash"
for config_file in $UTILITIES
do
  source $config_file
done

### End Misc Utilities ###

### Show current Git branch on prompt ###
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function git_status {
  git_status="$(git status 2> /dev/null)"
  if [[ ${git_status}} =~ "will be committed" ]]; then
    echo "*"
  fi
}

custom_prompt () {
  history -a
  history -c
  history -r

  # Attribute codes:
  #   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
  # Text color codes:
  #   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
  # Background color codes:
  #   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
  #   \[\e[01;36m\]
  PS1='\[\e]0;\w\a\]\n\[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;36m\]\h\[\e[01;37m\]:\[\e[00;33m\]\w \[\e[0m\]$(parse_git_branch)\[\e[01;31m\]$(git_status)\[\e[01;37m\]\n\$ '
}

PROMPT_COMMAND=custom_prompt

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

source "$HOME/.machine_specific_configs"

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
