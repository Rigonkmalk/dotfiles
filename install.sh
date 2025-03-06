#!/usr/bin/env bash

dst="$HOME/.config/"

if [ -z "$1" ]; then
    echo "No function name provided."
    exit 1
fi

setup_dotfiles () {
	cp nvim/ $dst
	cp tmux/ $dst
}

fetch_homedir () {
    cp -R $dst/nvim/ .
}

$1
