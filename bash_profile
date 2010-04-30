### Environment variables ###
export ARCHFLAGS="-arch x86_64"
export PATH="/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:~:$PATH:."
export MANPATH="/opt/local/share/man:$MANPATH"
export EDITOR='mate -w'
export LANG="en_US.UTF-8"
export CDPATH=".:~:~/projects/spix:~/projects/personal"

export CLICOLOR=1
export TERM=xterm-color
export LSCOLORS=DxGxcxdxCxegedabagacad

export JEWELER_OPTS="--rspec --gemcutter"

### Aliases ###

# projects #
alias pra='cd ~/projects/personal/pratico'
alias sand='cd ~/projects/sandbox'
alias le='cd ~/projects/personal/learnings/erlang'
alias lr='cd ~/projects/personal/learnings/ruby'
alias dotf='cd ~/projects/personal/dotfiles'

# ruby and rails related #
alias con='./script/console'
alias ser='./script/server'
alias lser='./script/server -e localhost'
alias gen='./script/generate'

alias tstart='thin start'
alias tstop='thin stop'

alias rmate='mate app/ config/ db/ lib/ public/ test/ spec/ stories/ examples/ features/ Capfile *.rb Rakefile README*'

alias rt='rake --trace'
alias rtf='rake test:functionals --trace'
alias rti='rake test:integration --trace'
alias rtl='rake test:lib --trace'
alias rtp='rake test:plugins --trace'
alias rtu='rake test:units --trace'

alias migrate='rake db:migrate db:test:prepare'
alias remigrate='rake db:migrate && rake db:migrate:redo && rake db:schema:dump db:test:prepare'
alias rdr='rake db:rollback'
alias rout='rake routes'
alias mrout='rake routes | mate'

alias dep='cap deploy'

# Git
alias git=hub
alias gadd='git add -u && git add . && git status'
alias git-wtf='~/.git-wtf'
alias git-publish-branch='~/.git-publish-branch'
alias git-rank-contributors='~/.git-rank-contributors'
alias git-show-merges='~/.git-show-merges'

# system #
alias home='cd ~'
alias l='ls -lah'
alias tf='tail -f'
alias mb='mate ~/.bash_profile'
alias rehash='source ~/.bash_profile'
alias clone='~/.terminal_clone_tab.sh'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias df='df -h'
alias du='du -h'

alias less='less -r'                          # raw control characters
alias grep='egrep --color'                    # show differences in colour

# textmate #
alias tm_update_bundles='sh ~/.update_tmbundles.sh'
alias tm_reload_bundles="osascript -e 'tell app \"TextMate\" to reload bundles'"

# Rubygems-related
alias unmerb='sh ~/.uninstall_merb.sh'
alias gems='cd /Library/Ruby/Gems/1.8/gems'

# Pair programming
alias pair='sh ~/.pair'
alias unpair='sh ~/.unpair'

# RabbitMQ #
alias startrabbit='sudo -H -u rabbitmq rabbitmq-server'

# Redis #
alias startredis='sudo redis-server /opt/local/etc/redis.conf'

### End Aliases ###

### SSH ###
# SSH_KNOWN_HOSTS=( $(cat ~/.ssh/known_hosts | \
#   cut -f 1 -d ' ' | \
#   sed -e s/,.*//g | \
#   uniq | \
#   egrep -v [0123456789]) )

# SSH_CONFIG_HOSTS=( $(cat ~/.ssh/config | grep "Host " | grep -v "*" | cut -f 2 -d ' ') )
#
# complete -o default -W "${SSH_KNOWN_HOSTS[*]} ${SSH_CONFIG_HOSTS[*]}" ssh

### End SSH ###

### Find_gem and edit_gem options ###
complete -C gem_autocomplete -o default find_gem
complete -C gem_autocomplete -o default edit_gem

# Rake autocompletion
complete -C ~/.rake_autocompletion.rb -o default rake

# bash-completion
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

export GEMDIR=`gem env gemdir`

gemdoc() {
  open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
}

_gemdocomplete() {
  COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
  return 0
}

complete -o default -o nospace -F _gemdocomplete gemdoc

### Show current Git branch on prompt ###
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
    # Attribute codes:
    #   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
    # Text color codes:
    #   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
    # Background color codes:
    #   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white
    #   \[\e[01;36m\]
    PS1='\[\e]0;\w\a\]\n\[\e[01;33m\]\u\[\e[01;37m\]@\[\e[01;36m\]\h\[\e[01;37m\]:\[\e[00;33m\]\w \[\e[0m\]$(parse_git_branch)\n\$ '
    export PS1
}
proml

# Method missing for bash.
# trap 'if ! type -t $BASH_COMMAND >/dev/null; then ~/.shell_method_missing.rb $BASH_COMMAND; fi' DEBUG

source ~/.gem_completion.sh

if [[ -s /Users/lucashungaro/.rvm/scripts/rvm ]] ; then source /Users/lucashungaro/.rvm/scripts/rvm ; fi