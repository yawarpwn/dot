#!/bin/env bash
set -euo pipefail

# Definicion de colores para mensajes
Color_Off=''
Red=''
Green=''
# Bold_Green=''
Bold_White=''

if [[ -t 1 ]]; then
  Color_Off='\033[0m'
  Red='\033[0;31m'
  Green='\033[0;32m'
  # Bold_Green='\033[1;32m'
  Bold_White='\033[1m'
fi

# Funciones para mostrar mensajes
error() {
  echo -e "${Red}error${Color_Off}: ${*}" >&2
}

info() {
  echo -e "${Bold_White}${*}${Color_Off}"
}

success() {
  echo -e "${Green}${*}${Color_Off}"
}

# Funcion para verificar si un comando existe
command_exists() {
  command -v "${1}" >/dev/null 2>&1
}

install() {
  local name=$1
  local install_cmd=$2

  if command_exists "${name}"; then
    success "${name} is already installed"
    return 0
  else
    info "Installing ${name}"
    if eval "$install_cmd"; then
      success "$name installed correctly"
      return 0
    else
      error "Error installing ${name}"
      return 1
    fi
  fi
}

# Intentar instalar starship
install "starship" "curl -sS https://starship.rs/install.sh | sh" || true

# Intentar instalar bun
install "bun" "curl -fsSL https://bun.sh/install | bash" || true

# Intentar instalar fnm
install "fnm" "curl -fsSL https://fnm.vercel.app/install | sh" || true

# Intentar instalar cargo
install "cargo" "curl https://sh.rustup.rs -sSf | sh" || true

#Install nodejs
if command_exists "fnm"; then
  info "installing Node.js LTS version"
  if fnm install --lts; then
    success "Node.js LTS version installed successfully"
  else
    error "Error installing Node.js LTS version"
  fi
else
  error "fnm is not installed. Skipping Node.js LTS installation"
fi
info "instalations finished"
