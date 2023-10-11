source env_parallel.zsh

alias endsession='/usr/lib/qt6/bin/qdbus org.kde.Shutdown /Shutdown org.kde.Shutdown.logout'
alias reset-plasma='kquitapp6 plasmashell || killall plasmashell; kstart plasmashell >/dev/null'

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
    rdp=wlfreerdp
else
    alias copy='xclip -selection c -r'
    alias paste='xclip -selection c -o'
    rdp=xfreerdp
fi

function mrdp {
    $rdp /size:1600x900 /tls-seclevel:0 /u:chieri /v:${1:-127.0.0.1}
}
