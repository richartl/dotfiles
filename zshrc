
# Path to your oh-my-zsh installation.
    export ZSH=/home/$USER/.oh-my-zsh
    export PYENV_ROOT=/home/$USER/.pyenv/
    export PYENV_SHIMS=/home/$USER/.pyenv/shims/
    export JENV_ROOT=/home/$USER/.jenv/
    export RIPPER_ROOT=/home/$USER/.ripper
    export RIPPER_MEDIA_ROOT=/home/$USER/mysync/
    export ANDROID_HOME=/home/$USER/Android/Sdk
    export JAVA_HOME=/usr/lib/jvm/java-8-jdk
    export MYNAME=CANDO
    export LC_ALL=en_MX.UTF-8

# System configs
    export EDITOR='vim'
    export TERM="xterm-256color"

# Set name of the theme to load.
    #ZSH_THEME="powerlevel9k/powerlevel9k"
    ZSH_THEME="agnoster"
    POWERLEVEL9K_PROMPT_ON_NEWLINE=true
    POWERLEVEL9K_DISABLE_RPROMPT=true
    POWERLEVEL9K_MODE='awesome-fontconfig'

    POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='004'
    POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='255'

    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='244'
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='255'

    POWERLEVEL9K_DIR_HOME_BACKGROUND='244'
    POWERLEVEL9K_DIR_HOME_FOREGROUND='255'

    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='244'
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='255'


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
    DISABLE_AUTO_TITLE="false"

# Uncomment the following line to enable command auto-correction.
    ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
    plugins=(git wd vi-mode)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

    source $ZSH/oh-my-zsh.sh

#Preferred editor for local and remote sessions
     if [[ -n $SSH_CONNECTION ]]; then
       export EDITOR='vim'
     else
       export EDITOR='vim'
     fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"


# Example aliases
    alias tx="tmux"
    alias txa="tmux a -t"
    alias txn="tmux new -s"
    alias tmux="tmux -2"
    alias fbe="fab environment:"
    alias vgru="vagrant up"
    alias vgrh="vagrant halt"
    alias vgrs="vagrant status"
    # Ctrl s
    alias vim="stty stop '' -ixoff ; vim"
    ttyctl -f # 'Frozing' tty, so after any command terminal settings will be restored

# Exports
    export LANG=en_US.UTF-8
    export PATH="/home/$USER/.bin:$JENV_ROOT/bin:$PYENV_SHIMS:$PATH:$HOME/.rvm/bin:$PYENV_ROOT/bin:$JAVA_HOME/lib" # Add RVM to PATH for scripting
    export SSH_KEY_PATH="~/.ssh/dsa_id"
    export NVM_DIR="/home/$USER/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

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

# Evals
    eval "$(jenv init -)"
    eval "$(pyenv init -)"

chmod +x ~/.vocab
~/.vocab
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
