# vi: se ft=zsh et:
#
# Shamelessly stolen from https://dustri.org/b/my-zsh-configuration.html
# and warped into my own version.

autoload -U colors select-word-style
colors
select-word-style bash

##
# Vcs info
##
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{$fg[yellow]%}%c%{$fg[green]%}%u%{$reset_color%} [%{$fg[blue]%}%b%{$reset_color%}] %{$fg[yellow]%}%s%{$reset_color%}:%r"
precmd() {  # run before each prompt
    vcs_info
}

##
# Prompt
##
setopt prompt_subst
if [ "$USER" = "root" ]; then
    usercolor="red"
    hostcolor="red"
    dircolor="red"
    signcolor="white"
else
    usercolor="green"
    hostcolor="cyan"
    dircolor="yellow"
    signcolor="black"
fi
RPROMPT='${vcs_info_msg_0_}'
prompt="%{$fg[$usercolor]%}%n%{$reset_color%}@%{$fg[$hostcolor]%}%m%{$reset_color%} %{$fg[$dircolor]%}%~%{$reset_color%} %{$fg[$signcolor]%}%#%{$reset_color%} "

##
# vi mode
##
bindkey -v

bindkey '^r' history-incremental-pattern-search-backward
bindkey '^p' up-history
bindkey '^n' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[blue]%}[% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} ${vcs_info_msg_0_} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

##
# Completion
##
autoload -U compinit
compinit
zmodload -i zsh/complist
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
unsetopt correct                # spelling correction for commands
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt menucomplete             # auto-complete the first menu item automatically

zstyle ':completion::complete:*' use-cache on               # completion caching, use rehash to clear
zstyle ':completion:*' cache-path ~/.zsh/cache              # cache path
zstyle ':completion:*' menu select=1                        # menu if nb items > 2
zstyle ':completion:*::::' completer _expand _complete _ignored # list of completers to use
zstyle ':completion:*' accept-exact '*(N)'

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

if whence dircolors >/dev/null; then
    eval "$(dircolors -b ~/dotfiles/contrib/dircolors-solarized/dircolors.ansi-dark)"
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
    alias ls='ls --color'
else
    export CLICOLOR=1
    unset LSCOLORS
fi

#generic completion with --help
compdef _gnu_generic gcc
compdef _gnu_generic r2
compdef _gnu_generic gdb
compdef _gnu_generic openssl

##
# Pushd
##
setopt auto_pushd               # make cd push old dir in dir stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt pushd_to_home            # `pushd` = `pushd $HOME`

##
# History
##
HISTFILE=~/.zsh_history         # where to store zsh config
HISTSIZE=4096                   # big history
SAVEHIST=4096                   # big history
setopt append_history           # append
setopt hist_ignore_all_dups     # no duplicate
unsetopt hist_ignore_space      # ignore space prefixed commands
setopt hist_reduce_blanks       # trim blanks
unsetopt hist_verify            # show before executing history commands
setopt inc_append_history       # add commands as they are typed, don't wait until shell exit
setopt share_history            # share hist between sessions
setopt bang_hist                # !keyword

##
# Various
##
setopt auto_cd                  # if command is a path, cd into it
unsetopt auto_remove_slash      # self explicit
setopt chase_links              # resolve symlinks
setopt extended_glob            # activate complex pattern globbing
setopt glob_dots                # include dotfiles in globbing
setopt print_exit_value         # print return value if non-zero
unsetopt beep                   # no bell on error
unsetopt bg_nice                # no lower prio for background jobs
setopt clobber                  # must use >| to truncate existing files
unsetopt hist_beep              # no bell on error in history
unsetopt hup                    # no hup signal at shell exit
unsetopt ignore_eof             # do not exit on end-of-file
unsetopt list_beep              # no bell on ambiguous completion
setopt rm_star_silent           # don't ask for confirmation for `rm *' or `rm path/*'
print -Pn "\e]0; %n@%M: %~\a"   # terminal title
export GCC_COLORS=1             # Colors in gcc

# Environment variables
export PATH=$PATH:~/bin:~/dotfiles/bin
export VISUAL="vim"
export EDITOR=$VISUAL
export MC_SKIN=~/dotfiles/mc/solarized.ini

# Syntax highlighting
source ~/dotfiles/contrib/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Standard aliases
alias c='clear'
alias dir='ls -l'
alias dirs='ls -l -d */'
alias dri='ls -l'
alias g='ack'
alias gita='git commit -a'
alias gitall='git commit -a -m'
alias i='ipython3'
alias mci='mvn clean install'
alias root='sudo su -'
alias tax='tmux detach >/dev/null 2>&1; tmux attach || tmux'

# Quick directory switcher
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# load keychain
if test -x /usr/bin/keychain; then
    eval `keychain -q -Q --eval id_rsa`
fi

# FZF shell integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Local customizations
custom_zsh=~/.zshrc.local
if test -f $custom_zsh; then
    source $custom_zsh
fi
