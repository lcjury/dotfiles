#-------------------------
# Bash shopts.
#-------------------------
shopt -s histappend # appends to the history instead of overwriting it.
shopt -s cmdhist # bash attemps to save multiple line commands in one history entry.
shopt -s lithist # save multi-line commands using \n instead of ,
#shopt -s no_empty_cmd_completion # if using tab on empty line, don't do anything.
shopt -s cdspell # if cd X, X is miss espelled, fix it.

#-------------------------
# Mist.
#-------------------------
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#-------------------------
# Aliases.
#-------------------------
alias ls='ls -G'
alias la='ls -la'
alias artisan='php artisan'
alias dartisan='docker-compose exec app php artisan'

#-------------------------
# Completion.
#-------------------------
complete -A alias         alias unalias
complete -A export        export printenv
complete -A shopt         shopt
complete -A directory     cd rmdir
complete -A signal        kill killall
complete -A job -P '%'    fg jobs
complete -A helptopic     help
complete -A command       which

#-------------
# bash promtp.
#-------------

#if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
#  export TERM=gnome-256color
#elif infocmp xterm-256color >/dev/null 2>&1; then
#  if [ `toe -a | grep -q xterm-256color-italics` ]; then
#  export TERM=xterm-256color-italics
#  else
#  export TERM=xterm-256color
#  fi
#fi

if tput setaf 1 &> /dev/null; then
  tput sgr0
  if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
    # Changed these colors to fit Solarized theme
    ORANGE=$(tput setaf 166)
    GREEN=$(tput setaf 64)
    PURPLE=$(tput setaf 61)
    WHITE=$(tput setaf 244)
  else
    ORANGE=$(tput setaf 4)
    GREEN=$(tput setaf 2)
    PURPLE=$(tput setaf 1)
    WHITE=$(tput setaf 7)
  fi
  BOLD=$(tput bold)
  RESET=$(tput sgr0)
else
  ORANGE="\033[1;33m"
  GREEN="\033[1;32m"
  PURPLE="\033[1;35m"
  WHITE="\033[1;37m"
  RESET="\033[m"
fi

export ORANGE
export GREEN
export PURPLE
export WHITE
export BOLD
export RESET

function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

function minutes_since_last_commit()
{
    now=`date +%s`
        last_commit=`git log --pretty=format:'%at' -1`
        seconds_since_last_commit=$((now-last_commit))
        minutes_since_last_commit=$((seconds_since_last_commit/60))
        echo $minutes_since_last_commit
}

export PS1="\[$ORANGE\]\h\[$WHITE\] \[$GREEN\]\w\[$WHITE\] \$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\$ \[$RESET\]"
export PS1="\[$ORANGE\]\h\[$WHITE\] \[$GREEN\]\w\[$WHITE\] \[$PURPLE\]\$\[$RESET\] "

if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
