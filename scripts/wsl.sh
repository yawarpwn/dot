#!/bin/bash

DIR="$(dirname "$0")"

source "$DIR"/utils.sh
source "$DIR"/functions.sh

function install_zsh_debian {
  local zsh="${DIR}/packages/zsh.list"
  local zshrc="${DIR}/dotfiles/zshrc"
  local p10krc="${DIR}/dotfiles/p10k"

  show_header "Installing Zsh."
  check_installed "${zsh}"
  show_success "Zsh installed."

  mkdir -p "${HOME}/.local/share/zsh/site-functions"

  copy_config_file "${zshrc}" "${HOME}/.zshrc"
  copy_config_file "${p10krc}" "${HOME}/.p10k.zsh"
}

function install_wsl() {
  local debian_packages="$DIR"/packages/debian.list

  #Instalar eza
  if ! command -v eza >/dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  fi

  ## Instalar packquetes debian
  show_info "Installing depedencies"
  install_debian_packages "$debian_packages"

  #Instalar neovim
  if ! command -v nvim >/dev/null; then
    show_info "Installing neovim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz
  else
    show_success "Neovim is already installed"
  fi

  #Instalar Starship
  # if ! command -v startship; then
  #   curl -sS https://starship.rs/install.sh | sh
  # else
  #   show_success "Starship is already installed"
  # fi

  #Install pk10
  if [ ! -d "$HOME"/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  else
    show_success "powerlevel10k is already installed"
  fi

  install_zsh_debian
}

install_wsl
