# Created:  Mon 21 Sep 2015
# Modified: Tue 03 Oct 2017
# Author:   Josh Wainwright
# Filename: bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TMP=/tmp
export PATH=$PATH:"/cygdrive/c/Program Files/Mozilla Firefox"
export EDITOR=vim #vis
export PAGER=less
export BROWSER=firefox
export MEDIA=mpv
export WIKIDIR=~/Documents/Details

## Options
shopt -s autocd
shopt -s cdspell
shopt -s checkjobs
shopt -s checkwinsize
shopt -s cmdhist
shopt -s completion_strip_exe &> /dev/null
shopt -s dirspell
shopt -s dotglob
shopt -s extglob
shopt -s globstar
shopt -s histappend
shopt -s histreedit
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
set -o noclobber

## Prompt
set_prompt() {
	lastcmd=$?
	P_RED='\[\e[0;31m\]'
	P_CYAN='\[\e[0;36m\]'
	P_GREEN='\[\e[0;32m\]'
	P_GREY='\[\e[0;33m\]'
	P_NC='\[\e[0m\]'
# 	PROMPT_DIRTRIM=2

	PS1="\n${P_CYAN}\w  ${P_GREY}\j ${P_NC}[\H]\n"
	if [ $lastcmd -eq 0 ]; then
		PS1+=${P_GREEN}
		history -a
	else
		PS1+=${P_RED}
	fi
	printf -v str "%${SHLVL}s";
	PS1+="${str// />}${P_NC} "
	pwd=${PWD/$HOME/\~}
	printf "\x1b]2;$pwd\x07"
}
PROMPT_COMMAND='set_prompt'

## History
HISTCONTROL=ignorespace:ignoredups:erasedups
HISTFILE=~/.bash_history
HISTSIZE=-1
HISTFILESIZE=-1
HISTIGNORE="&:[ ]*:exit:ls:ll:bg:fg*:history:clear:vim"
HISTTIMEFORMAT='%F %T'

export LANG=en_GB.UTF-8

bind 'Space: magic-space'
bind '"\e[1;5C": forward-word'
bind '"\e[1;5D": backward-word'
bind '"\e[5C": forward-word'
bind '"\e[5D": backward-word'
bind '"\e\e[C": forward-word'
bind '"\e\e[D": backward-word'

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

stty werase undef
bind '"\C-w": backward-kill-word'
bind 'set bell-style none'
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set expand-tilde on'
bind 'set mark-directories on'
bind 'set mark-symlinked-directories on'
bind 'set match-hidden-files on'
bind 'set colored-stats on'

# Colours
LS_COLORS="no=90:fi=0:di=32:ln=35:so=34:pi=34:ex=33:bd=34:cd=34:su=34:sg=34:tw=1;32:ow=1;32"
export LS_COLORS

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0272822" #black
    echo -en "\e]P875715e" #darkgrey
    echo -en "\e]P1f92672" #darkred
    echo -en "\e]P9cc064e" #red
    echo -en "\e]P2a6e22e" #darkgreen
    echo -en "\e]PA7aac18" #green
    echo -en "\e]P3f4bf75" #brown
    echo -en "\e]PBf0a945" #yellow
    echo -en "\e]P466d9ef" #darkblue
    echo -en "\e]PC33c7e9" #blue
    echo -en "\e]P5ae81ff" #darkmagenta
    echo -en "\e]PD7e33ff" #magenta
    echo -en "\e]P6a1efe4" #darkcyan
    echo -en "\e]PE5fe3d2" #cyan
    echo -en "\e]P7f8f8f2" #lightgrey
    echo -en "\e]PFf9f8f5" #white
    clear #for background artifacting
fi

# Aliases
alias type='type -a'
alias vimrc='vim -c ":e \$MYVIMRC"'
alias ll='ls --color=auto -NGghmn --time-style=+"" --group-directories-first'
alias la='ll -A'
alias mv='mv -i -v'
alias rm='rm -v'
alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
alias mpv='mpv --save-position-on-quit'
alias mute-beep='xset -b && sudo rmmod pcspkr'
alias vimp='vim ~/Documents/Details/pass.gpg'

_git_log_oneline_format='%C(yellow)%h%C(reset) %C(green) %ad %C(reset) %s %C(white)- %an%C(reset)%C(yellow)%d%C(reset)'
alias gl='git log --topo-order --pretty=format:${_git_log_medium_format}'
alias gll='git log --graph --abbrev-commit --date=relative --format=format:"${_git_log_oneline_format}" --all'
alias gws='git status --ignore-submodules --short'
alias gwd='git diff --no-ext-diff'

function pwgen() {
	< /dev/urandom tr -dc A-Za-z0-9 | head -c${1:-16};echo;
}
function cd {
	builtin cd "$@" > /dev/null && ll
}

