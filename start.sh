#!/bin/bash

#check deps
packages_list=(stow)
pacman -S --needed --noconfirm "${packages_list[@]}"

# Config git
git config --global user.name ""
git config --global user.email ""

# Stow dotfiles
mv "$HOME/.config/nvim" "$HOME/.config/nvim_$(date +%Y%m%d-%k%M%S)"
