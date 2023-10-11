alias vi='nvim'
alias vim='nvim'
alias tree='tree --dirsfirst --filelimit=32 -F'
alias truecrypt='veracrypt -t'

alias rmeol="sed -i -z 's/\n*$//'"
alias oneeol="sed -i -z 's/\n*$/\n/'"
alias rmbom="sed -i -z $'s/^\uFEFF//'"

UA='"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.3"'
alias wget="wget -U $UA --content-disposition"
alias wget-clone='wget --mirror --convert-links --adjust-extension --page-requisites --no-parent'
alias curl="curl -A $UA --location"

function shaname() {
    local extension="${1##*.}"
    local sha=`shasum -a 256 "$1"`
    mv -f "$1" `dirname "$1"`/"${sha:0:16}.${extension:l}"
}

# > getpwd 0 0 0
# Ay00-7Ofr/mL0J-cpEB
function getpwd() {
    if [ "$#" -ne 2 ]; then return 1; fi
    echo "Account: $2@$1"
    read "key?Master Key: "
    local b64=`echo -n "$@ $key Ciallo~" | openssl dgst -binary -sha256 | openssl base64 -A`
    echo Ay00-${b64:0:4}/${b64:4:4}-${b64:8:4} | sed 's/+/-/g'
    unset key
}

## JS
# const encoder = new TextEncoder();
# const keystr = prompt('Host User MasterKey:') + ' Ciallo~';
# const keybuf = encoder.encode(keystr);
# crypto.subtle.digest('SHA-256', keybuf).then(sha256 => {
#     const b64 = btoa(String.fromCharCode(...new Uint8Array(sha256)));
#     console.log(`Ay00-${b64.slice(0,4)}/${b64.slice(4, 8)}-${b64.slice(8, 12)}`.replaceAll('+', '-'));
# });

function pg() { ps -ef | grep "$@" | grep -v grep; }

function tg() {
    if [ -f "../${PWD##*/}.tar.gz" ]; then
        echo "../${PWD##*/}.tar.gz" exists. Abord.
        return 233
    else
        tar -czvf "../${PWD##*/}.tar.gz" "../${PWD##*/}"
        ${aliases[open]:-open} ..
    fi
}

function utg() { tar -xzvf "$@" && rm $1; }

function zipdir() {
    zip -x '*.DS_Store' -x '._*' -r $1.zip $1
}

function unzip() {
    /usr/bin/unzip "$@" -x '__MACOSX/*' '*/.DS_Store' '*/._*' && rm $1
}

function aget() {
curl http://localhost:6800/jsonrpc -d @- <<EOF
{ "jsonrpc": "2.0", "method": "aria2.addUri", "id": "curl", "params": [["$@"]] }
EOF
}

function mrdp() {
    if [ $XDG_SESSION_TYPE = "wayland" ]; then rdp=wlfreerdp
    else rdp=xfreerdp; fi
    $rdp /size:1600x900 /tls-seclevel:0 /u:$user /p:$pwd /v:${1:-127.0.0.1}
}

function pdf-merge() {
    pdftk "$@" cat output merged.pdf
}

function pdf-rotate() {
    pdftk "$1" cat 1-endeast output /tmp/rotated.pdf && mv /tmp/rotated.pdf "$1"
}

function pdf-compress() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dPDFSETTINGS=/ebook -sOutputFile="$2" "$1"
}

function spcue() {
    cue="$1"
    aud="$2"
    disc="$3"
    if [ -z "$cue" ]; then
        cue=`find . -maxdepth 1 -name '*.cue' -print -quit`
    fi
    if [ -z "$aud" ]; then
        aud=`find . -maxdepth 1 \( -name '*.flac' -o -name '*.wav' \) -print -quit`
    fi

    rmbom "$cue"
    shnsplit -f "$cue" -o flac -t "${3}%n-%t" "$aud"
    rm 00-pregap.flac 2>/dev/null
    if [ $? -eq 0 ]; then
        rm "$aud"
    else
        return 1
    fi
    cuetag.sh "$cue" *.flac
}
