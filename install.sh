#!/bin/bash

function sep () {
	echo -e "---------------------------"
}

function log () {
	echo -e "\033[1;34m $1 \033[0m"
}

function check () {
	echo -e "\033[1;33m $1 \033[0m"
}

function ok () {
	echo -e "\033[1;32m ok \033[0m"
}

function error () {
	echo -e "\033[1;35m DEPENDENCY ERORR MISSING COMMAND: $1 \033[0m"
}

function checkcommand () {
    sep # separator
    check "Cheking '$1' command"
    PL=$(command -v $1)

    if [ $? -eq 1 ]
    then # if vikmatrixterm does not exist
        error "$1"
        check "Check README.md to install dependencies"
        exit 1
    else
        ok
    fi
}

checkcommand "pyxtrlock"

checkcommand "unimatrix"

checkcommand "xargs"

sep # separator
check "Cheking 'vikmatrixterm' command"
VMT=$(command -v vikmatrixterm)

if [ $? -eq 1 ]
then # if vikmatrixterm does not exist
    log "Creating symbolic link under /usr/bin"
    sudo ln -s $PWD/vikmatrixterm /usr/bin/vikmatrixterm
else
    log "vikmatrixterm already exist under /usr/bin"
    if [[ $1 == "update" ]]; then
        log "Updating symbolic links"
        sudo unlink /usr/bin/vikmatrixterm
        sudo ln -s $PWD/vikmatrix /usr/bin/vikmatrixterm
    else
        check "- if you want to update the link run: \033[1;35m./install.sh uptade"
    fi
fi
ok # print ok
sep # separator
check "Cheking 'vikmatrix' command"
VM=$(command -v vikmatrix)

if [ $? -eq 1 ]
then # if vikmatrix does not exist
    log "Creating symbolic link under /usr/bin"
    sudo ln -s $PWD/vikmatrix /usr/bin/vikmatrix
else
    log "vikmatrix already exist under /usr/bin"
    if [[ $1 == "update" ]]; then
        log "Updating symbolic links"
        sudo unlink /usr/bin/vikmatrix
        sudo ln -s $PWD/vikmatrix /usr/bin/vikmatrix
    else
        check "- if you want to update the link run: \033[1;35m./install.sh uptade"
    fi
fi
ok
sep
log "Installation complete"
log "  usage: vikmatrix   "