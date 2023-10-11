source env_parallel.zsh

alias endsession='qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout'

function open {
    if [ -e $1 ]; then
        xdg-open $1 >/dev/null 2>&1
    else
        return 233
    fi
}

function trash {
    kioclient move "$@" 'trash:/'
}

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    alias copy='wl-copy --trim-newline'
    alias paste='wl-paste -t text --no-newline'
else
    alias copy='xclip -selection c -r'
    alias paste='xclip -selection c -o'
fi

__conda_setup="$('~/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/miyu/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/miyu/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/miyu/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
