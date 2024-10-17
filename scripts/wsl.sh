#!/bin/bash

DIR="$(dirname "$0")"

source "$DIR"/utils.sh
source "$DIR"/functions.sh

function install_zsh_debian {
  local zshrc="${DIR}/../.zshrc"
  local p10krc="${DIR}/../.p10k.zsh"

  mkdir -p "${HOME}/.local/share/zsh/site-functions"

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
  if ! command -v fnm >dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
  else
    show_success "Neovim is already fnm installed"
  fi
}

function install_Packages_debian {
  sudo apt install -y \
    git \
    curl \
    fzf \
    git \
    man-db \
    gcc \
    wget \
    unzip \
    tar \
    zoxide \
    fd-find \
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions
}

function install_wsl() {
  local debian_packages="$DIR"/packages/debian.list

  #Instalar eza
  #if ! command -v eza >/dev/null; then
  # sudo mkdir -p /etc/apt/keyrings
  # wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
  # echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
  # sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
  #fi

  install_zsh_debian
  install_fnm
  install_neovim

  #Install pk10
  if [ ! -d "$HOME"/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  else
    show_success "powerlevel10k is already installed"
  fi

  set set_bash_shell

}

install_wsl
