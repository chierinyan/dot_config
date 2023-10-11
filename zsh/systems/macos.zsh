eval "$(/usr/local/bin/brew shellenv)"

alias python='python3'

alias paste='pbpaste'
alias copy='pbcopy'

function code() {
    if [[ $# = 0 ]]
    then
        open -a 'Visual Studio Code'
    else
        F=`readlink -f $1`
        open -a 'Visual Studio Code' --args "$F"
    fi
}

function tower() {
    if [[ $# = 0 ]]
    then
        open -a 'Tower'
    else
        F=`readlink -f $1`
        open -a 'Tower' --args "$F"
    fi
}

function prl() {
	open -a 'Parallels Desktop'
	sleep 2
	prlctl start ${1:-'win11'}
}
