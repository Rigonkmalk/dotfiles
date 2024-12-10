#!/usr/bin/env bash

setup_dotfiles () {
	local dst="$HOME/.config/"

	mv nvim/ $dst
}

setup_dotfiles
