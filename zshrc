# Path to your oh-my-zsh installation.
    export ZSH=/home/$USER/.oh-my-zsh
    export ANDROID_HOME=/home/$USER/Android/Sdk
    export JAVA_HOME=/usr/lib/jvm/java-8-jdk
    export TUSK_HOME=/opt/Tusk
    export MYNAME=ALIENWARE
    export LC_ALL="en_US.utf8"
    export GOPATH=/home/$USER/go

# System configs
    export EDITOR="vim"
    export TERM="xterm-256color"
    ZSH_THEME="agnoster"
    DISABLE_AUTO_TITLE="false"
    ENABLE_CORRECTION="false"
    plugins=(git wd vi-mode)
    source $ZSH/oh-my-zsh.sh

#Preferred editor for local and remote sessions
     if [[ -n $SSH_CONNECTION ]]; then
       export EDITOR="vim"
     else
       export EDITOR="vim"
     fi

    # Ctrl s
    alias vim="stty stop '' -ixoff ; vim"
    ttyctl -f # 'Frozing' tty, so after any command terminal settings will be restored

# Exports
    export LANG=en_US.UTF-8
    export PATH="/home/$USER/.bin:$PATH:$HOME/.rvm/bin:$JAVA_HOME/lib:$TUSK_HOME:$GOPATH/bin" # Add RVM to PATH for scripting
    export SSH_KEY_PATH="~/.ssh/dsa_id"
    export NVM_DIR="/home/$USER/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"

# Alias
    alias txa="tmux a -t"

#Powerline
    if [ -d "$HOME/.local/bin" ]; then
        PATH="$HOME/.local/bin:$PATH"
    fi

#vi-mode
    bindkey -v

    bindkey '^P' up-history
    bindkey '^N' down-history
    bindkey '^?' backward-delete-char
    bindkey '^h' backward-delete-char
    bindkey '^w' backward-kill-word
    bindkey '^r' history-incremental-search-backward
    function zle-line-init zle-keymap-select {
        VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
        RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
        zle reset-prompt
    }

    zle -N zle-line-init
    zle -N zle-keymap-select
    export KEYTIMEOUT=1

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ./.bin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
