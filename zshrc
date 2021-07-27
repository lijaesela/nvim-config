# rc editing
alias zrc="nvim ~/.zshrc && exec zsh"
alias vrc="nvim ~/.config/nvim/init.vim"

autoload -Uz compinit && compinit
bindkey -e

export PATH="$HOME/bin:$PATH"

# chad prompt
PROMPT="%n@%m:%~$ "
t_start=$(date +%I:%M:%S)                # time of shell start
precmd () { t_prompt=$(date +%I:%M:%S) } # time current prompt appeared
preexec () {
    t_exec=$(date +%I:%M:%S)             # time command execution began
    printf "[1A[2K[33m%s [m%s [34m%s\n[m" \
           "$t_exec" "$" "$1"
}

# convenience
alias c="clear"
alias p="pacman"
alias dp="doas pacman"
alias ez="exec zsh"
alias ls='ls --color=auto'
alias tset="tput reset"

qc () { # $1: src, $2: compiler
	if [ "$2" ]; then
		_cc="$2"
	else
		_cc="cc"
	fi
	_exe="$(basename "$1")"
	_exe="${_exe%.*}"
	$_cc -o "$_exe" "$1"
}

# syntax
#. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autosuggestions
#. /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
