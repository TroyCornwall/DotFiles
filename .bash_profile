echo "Loading .bash_profile..."
alias msbuild="MSBuild.exe $*"
alias vs="devenv.exe -edit $*" #vs() { devenv -edit $* & }
alias code="code $*"
alias far="ConEmu64.exe -ct -font 'Lucida Console' -size 16 -cmd far.exe '.'"

PS1='\[\033]0;${PWD//[^[:ascii:]]/?}\007\]' # set window title

# non-printable characters must be enclosed inside \[ and \]
PS1="$PS1"'\[\033[1;32m\]'            # set colour to green
PS1="$PS1"'\w'                  # current working directory

if test -z "$WINELOADERNOEXEC"
then
    GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
    COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
    COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
    COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
    if test -f "$COMPLETION_PATH/git-prompt.sh"
    then
        . "$COMPLETION_PATH/git-completion.bash"
        . "$COMPLETION_PATH/git-prompt.sh"
        PS1="$PS1"'\[\033[1;34m\]'  # set colour to blue
        PS1="$PS1"'`__git_ps1`'   # bash function
    fi
fi

PS1="$PS1"'\n'                  # new line
PS1="$PS1"'\[\033[1;33m\]'      # set colour to yellow
PS1="$PS1"'λ: '                 # space
PS1="$PS1"'\[\033[0m\]'         # change color

echo "Configuring history..."
# ignore duplicates
export HISTCONTROL=ignoreboth:erasedups

# unlimited bash history
export HISTFILESIZE=
export HISTSIZE=
PROMPT_COMMAND='history -a ~/.bash_history'

echo "Sourcing completion files..."
source /c/Dev/bash-it/completion/available/awscli.completion.bash
source /c/Dev/bash-it/completion/available/docker.completion.bash
source /c/Dev/bash-it/completion/available/docker-compose.completion.bash
source /c/Dev/bash-it/completion/available/gem.completion.bash
source /c/Dev/bash-it/completion/available/npm.completion.bash
# source /c/Dev/public/bash-it/completion/available/packer.completion.bash
source /c/Dev/bash-it/completion/available/terraform.completion.bash

alias docker-kill-all='docker kill $(docker ps -q)'
alias docker-delete-stopped='docker rm -f $(docker ps -a -q)'
alias docker-rmi-all='docker rmi -f $(docker images -q)'

# bunch of setup for prompt
       BLACK="\[\033[0;30m\]"
         RED="\[\033[0;31m\]"
      YELLOW="\[\033[1;33m\]"
       GREEN="\[\033[0;32m\]"
        BLUE="\[\033[1;34m\]"
      PURPLE="\[\033[0;35m\]"
        CYAN="\[\033[0;36m\]"
   LIGHT_RED="\[\033[1;31m\]"
 LIGHT_GREEN="\[\033[1;32m\]"
LIGHT_YELLOW="\[\033[1;33m\]"
  LIGHT_BLUE="\[\033[1;34m\]"
       WHITE="\[\033[1;37m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
  COLOR_NONE="\[\033[0m\]" #"\[\e[0m\]"
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine=$'\n'  # https://stackoverflow.com/questions/33220492/ps1-bash-command-substitution-not-working-on-windows-10
SeeHere='└─'
Arrow='▶'
GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
GIT_COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
GIT_COMPLETION_PATH="${GIT_COMPLETION_PATH%/lib/git-core}"
GIT_COMPLETION_PATH="$GIT_COMPLETION_PATH/share/git/completion"

echo "Configuring prompt..."
PS1="${GREEN}${PathShort} ${LIGHT_YELLOW}(\$(aws_prompt_info))"
if test -f "$GIT_COMPLETION_PATH/git-prompt.sh"; then
  . "$GIT_COMPLETION_PATH/git-completion.bash"
  . "$GIT_COMPLETION_PATH/git-prompt.sh"
  PS1="$PS1""${BLUE}"'`__git_ps1`'
fi
PS1="$PS1""${NewLine}${GREEN}${SeeHere} λ: ${COLOR_NONE}"

export PATH="$PATH:/C/opt"
export DOTNET_SKIP_FIRST_TIME_EXPERIENCE=true
export PY_SCRIPTS="$HOME/appdata/local/programs/python/python36-32/Scripts"
export PATH="$PATH:$PY_SCRIPTS"
export JAVA_HOME="/c/Program Files/Java/jdk1.8.0_172"
export PATH="$PATH:$JAVA_HOME/bin"

source ~/.xero_bash
