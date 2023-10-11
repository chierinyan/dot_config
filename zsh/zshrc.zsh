export TERM='xterm-256color'
export EDITOR='nvim'

export PATH=$PATH:${HOME}/.local/bin:${HOME}/go/bin

# set prompt
preexec() { PREEXEC_CALLED=1 }
precmd() {
    RETURN_CODE=$?
    if [[ -v VIRTUAL_ENV ]] || [[ -v CONDA_DEFAULT_ENV ]]; then
        if [[ -v CONDA_DEFAULT_ENV ]]; then VIRTUAL_ENV_PROMPT=${CONDA_DEFAULT_ENV}
        else VIRTUAL_ENV_PROMPT=${${VIRTUAL_ENV%/*}##*/}; fi
        LHS="%F{25}<${VIRTUAL_ENV_PROMPT}>%f%U%(3~|.../%2~|%~)%u"
    else
        LHS="%B%F{25}|%f%b%U%(4~|.../%3~|%~)%u"
    fi
    if [[ "$RETURN_CODE" != 0 ]] && [[ "$PREEXEC_CALLED" = 1 ]]
    then PROMPT="%B%F{88}[%F{202}%S%m%s%f%b${LHS}%B%F{88}]%f%b "
    else PROMPT="%B%F{34}[%F{245}%S%m%s%f%b${LHS}%B%F{34}]%f%b "
    fi
    PREEXEC_CALLED=0
}

# set dir stack
DIRSTACKSIZE=9
setopt autopushd pushdminus pushdsilent pushdtohome pushdignoredups

# history
HISTSIZE=1024
SAVEHIST=1024
HISTFILE="${HOME}/.zsh_history"
HISTORY_IGNORE='clear|pwd|exit|cd*|rm*|du*|man*|7z*|unzip*|unrar*|history*|* --help'

setopt EXTENDED_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt BANG_HIST HIST_VERIFY


zstyle ':prezto:load' pmodule \
        'utility' \
        'rsync' \
        'terminal' \
        'environment' \
        'autosuggestions' \
        'syntax-highlighting' \
        'history-substring-search' \
        'completion'

zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:utility' correct 'no'
zstyle ':prezto:module:syntax-highlighting' highlighters \
        'main' \
        'brackets' \
        'pattern' \
        'regexp'

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source $HOME/.config/zsh/prezto/init.zsh
for rc in $HOME/.config/zsh/rc.d/*.zsh; do source $rc; done

__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then eval "$__conda_setup"; fi
unset __conda_setup
