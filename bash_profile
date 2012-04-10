### Environment variables ###
export CFLAGS="-arch x86_64 -O2"
export ARCHFLAGS="-arch x86_64"
export CC="/usr/bin/gcc-4.2"

export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:~:$PATH:."
export MANPATH="/opt/local/share/man:$MANPATH"
export CDPATH=".:~:~/projects/gonow:~/projects/personal"
export LANG="en_US.UTF-8"

export NODE_PATH="/usr/local/lib/node"

export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=DxGxcxdxCxegedabagacad

export EDITOR="mate -w"

### Aliases ###

# projects #
alias pra="cd ~/projects/personal/pratico"
alias sand="cd ~/projects/sandbox"
alias le="cd ~/projects/personal/learnings/erlang"
alias lr="cd ~/projects/personal/learnings/ruby"
alias dotf="cd ~/projects/personal/dotfiles"

# ruby and rails related #
alias con="rails console"
alias ser="rails server"
alias gen="rails generate"

alias rmate="mate app/ config/ db/ lib/ public/ test/ spec/ stories/ examples/ features/ Capfile *.rb *.ru Rakefile README* Gemfile*"
alias em="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"
alias v="mvim ."

alias rt="be rake --trace"
alias rsp="be rake spec"
alias r="be rspec"

alias migrate="be rake db:migrate db:test:prepare"
alias remigrate="be rake db:migrate && rake db:migrate:redo && rake db:schema:dump db:test:prepare"
alias rdr="be rake db:rollback"
alias rout="be rake routes"
alias mrout="be rake routes | mate"

alias dep="be cap deploy"

# Bundler
alias b="bundle"
alias bi="b install --path vendor"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

# Git
alias git=hub
alias gadd="git add -u && git add . && git status -sb"
alias git-wtf="~/.git-wtf"
alias git-publish-branch="~/.git-publish-branch"
alias git-rank-contributors="~/.git-rank-contributors"
alias git-show-merges="~/.git-show-merges"

# system #
alias home="cd ~"
alias l="ls -lah"
alias tf="tail -f"
alias mb="mate ~/.bash_profile"
alias rehash="source ~/.bash_profile"
alias clone="~/.terminal_clone_tab.sh"

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

alias df="df -h"
alias du="du -h"

alias less="less -r"                          # raw control characters
alias grep="egrep --color"                    # show differences in colour

# textmate #
alias tm_update_bundles="sh ~/.update_tmbundles.sh"
alias tm_reload_bundles="osascript -e 'tell app \"TextMate\" to reload bundles'"

# Rubygems-related
alias gems="cd $GEM_HOME"
alias edit_gem="~/.edit_gem"

# Pair programming
alias pair="sh ~/.pair"
alias unpair="sh ~/.unpair"

# Misc #
alias speedup="sudo rm -rf /private/var/log/asl/*"

# PostgreSQL #
alias postgresql.start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias postgresql.stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Redis #
alias redis.start="redis-server /usr/local/etc/redis.conf"

# General #
alias lserv="open http://localhost:8000 && python -m SimpleHTTPServer"

### End Aliases ###


### Completions ###
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
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


# Method missing for bash.
# trap 'if ! type -t $BASH_COMMAND >/dev/null; then ~/.shell_method_missing.rb $BASH_COMMAND; fi' DEBUG

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
  PS1='\[\e]0;\w\a\]\n\[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;36m\]\h\[\e[01;37m\]:\[\e[00;33m\]\w \[\e[0m\]$(parse_git_branch)\e[01;31m\]$(git_status)\[\e[01;37m\]\n\$ '
}

PROMPT_COMMAND=custom_prompt