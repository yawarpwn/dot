#!/bin/env sh
set -euo pipefail


# Definición de colores para mensajes
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

# Función para verificar si un comando existe
command_exists() {
  command -v "${1}" >/dev/null 2>&1
}


# Función para instalar paquetes usando pacman
install_pacman() {
  local packages=("$@")
  info "Installing packages: ${packages[*]}"
  if pacman -S --needed --noconfirm "${packages[@]}"; then
    success "Packages installed successfully"
  else
    error "Error installing packages"
  fi
}

# Lista de paquetes a instalar
packages=(
  less
  starship
  grep
  htop
  zoxide
  lazygit
  unzip
  unrar
  neovim
  wget
  fastfetch
  base-devel
  stow
  eza
  xsel
  ripgrep
  fish
  fzf
  fd
)

# Instalar paquetes con pacman
install_pacman "${packages[@]}"

# Función para instalar software adicional
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
install "bun" "curl -fsSL https://bun.sh/install | sh" || true

# Intentar instalar fnm
install "fnm" "curl -fsSL https://fnm.vercel.app/install | sh" || true

# Intentar instalar cargo
install "cargo" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh" || true

# Instalar Node.js LTS si fnm está disponible
if command_exists "fnm"; then
  info "Installing Node.js LTS version"
  if fnm install --lts; then
    success "Node.js LTS version installed successfully"
  else
    error "Error installing Node.js LTS version"
  fi
else
  error "fnm is not installed. Skipping Node.js LTS installation"
fi


info "Installations finished"
