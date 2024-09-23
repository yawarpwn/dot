#!/bin/bash

files=(rofi openbox polybar picom dunst nitrogen)

dots=(.zshrc .bashrc .p10k.zsh .bash_profile)

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
