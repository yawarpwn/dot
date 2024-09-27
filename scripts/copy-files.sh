#!/bin/bash

files=(rofi openbox polybar picom dunst nitrogen bspwm sxhkd xsettingsd kitty)

dots=(.zshrc .bashrc .p10k.zsh .bash_profile .fehbg)

for file in "${files[@]}"; do
  rm -rf "$HOME/dot/scripts/dotfiles/$file"
  echo "deleted: $file"
  cp -r "$HOME/.config/$file" "$HOME/dot/scripts/dotfiles/"
done

for dot in "${dots[@]}"; do
  rm -rf "$HOME/dot/scripts/dotfiles/$dot"
  echo "deleted: $dot"
  cp -r "$HOME/$dot" "$HOME/dot/scripts/dotfiles/"
done
