#!/bin/bash

DIR="$(dirname "$0")"

source "$DIR"/utils.sh
source "$DIR"/functions.sh

function set_zsh_shell_debian {
  show_header "Setting zsh shell"
  local zshrc="${DIR}/../.zshrc"
  local p10krc="${DIR}/../.p10k.zsh"

  mkdir -p "${HOME}/.local/share/zsh/site-functions"

  #Install pk10
  if [ ! -d "$HOME"/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  else
    show_success "powerlevel10k is already installed"
  fi

  if ! command -v zsh >/dev/null 2>&1; then
    show_warning "Zsh not installed. Skipping."
    return
  fi

  if ! grep -q "zsh" <(getent passwd "$(whoami)"); then
    show_info "Changing login shell to Zsh. Provide your password."
    chsh -s /bin/zsh
  else
    show_info "Default shell already set to Zsh."
  fi

  copy_config_file "${zshrc}" "${HOME}/.zshrc"
  copy_config_file "${p10krc}" "${HOME}/.p10k.zsh"
}

function set_bash_shell {
  show_info "setting bash shell"
  local bashrc="$DIR/../.bashrc"
  mv "${HOME}/.bashrc" "${HOME}/.bashrc-back"
  copy_config_file "${bashrc}" "${HOME}/.bashrc"
}

function install_neovim() {

  if ! command -v nvim >/dev/null; then
    local temp_dir=$(mktemp -d)
    local url="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"
    curl -L -o "$temp_dir/nvim-linux64.tar.gz" "$url"

    # Verificar si la descarga fue exitosa
    if [ $? -eq 0 ]; then
      echo "Descarga completada: $temp_dir/nvim-linux64.tar.gz"

      # Eliminar el directorio de instalación si ya existe
      if [ -d /opt/nvim ]; then
        echo "Eliminando el directorio existente /opt/nvim..."
        sudo rm -rf /opt/nvim
      fi

      # Descomprimir el archivo en /opt
      echo "Descomprimiendo el archivo..."
      sudo tar -C /opt -xzf "$temp_dir/nvim-linux64.tar.gz"

      echo "Neovim instalado en /opt/nvim."
    else
      echo "Error en la descarga."
    fi

    sudo ln -s /opt/nvim-linux64/bin/nvim /usr/bin/nvim

    # Borrar el directorio temporal
    rmdir "$temp_dir"
  else
    show_success "Neovim is already installed"
  fi

  copy_config_file "/home/johneyder/dot/config/nvim" "/home/johneyder/.config/nvim"

}

function install_fnm {
  if ! command -v fnm >/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
  else
    show_success "Fnm package already installed"
  fi
}

function install_debian_deps {
  local debian_deps="$DIR/packages/debian.list"
  show_header "Check dependencies"
  local package
  while read -r package; do
    if ! dpkg -l | grep -qw "${package}"; then
      show_info "${package@Q} is needed for this script"
      sudo apt install -y "$package"
      show_success "${package@Q} is already installed."
    else
      show_success "${package@Q} is already installed."
    fi
  done <"${debian_deps}"
}

function install_wsl() {
  #Instalar eza
  if ! command -v eza >/dev/null; then
    sudo mkdir -p /etc/apt/keyrings
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    sudo apt update
  fi
  install_debian_deps
  install_fnm
  install_neovim
  set_zsh_shell_debian
}

install_wsl
