#!/usr/bin/env bash

setup_dotfiles () {
	local dst="$HOME/.config/"

	cp nvim/ $dst
	cp tmux/ $dst
}

setup_dotfiles
