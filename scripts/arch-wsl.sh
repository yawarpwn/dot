#!/bin/bash

DIR="$(dirname "$0")"

source "$DIR"/utils.sh
source "$DIR"/functions.sh

function set_zsh_shell_debian {
  show_header "Configurando Zsh como shell"
  local zshrc="${DIR}/../.zshrc"
  local p10krc="${DIR}/../.p10k.zsh"

  mkdir -p "${HOME}/.local/share/zsh/site-functions"

  # Instalar powerlevel10k si no está instalado
  if [ ! -d "$HOME"/powerlevel10k ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  else
    show_success "powerlevel10k ya está instalado"
  fi

  # Verificar si Zsh está instalado
  if ! command -v zsh >/dev/null 2>&1; then
    show_warning "Zsh no está instalado. Saltando."
    return
  fi

  # Cambiar el shell de inicio de sesión a Zsh si no está configurado
  if ! grep -q "zsh" <(getent passwd "$(whoami)"); then
    show_info "Cambiando el shell de inicio de sesión a Zsh. Proporciona tu contraseña."
    chsh -s /bin/zsh
  else
    show_info "El shell predeterminado ya está configurado a Zsh."
  fi

  # Copiar archivos de configuración
  copy_config_file "${zshrc}" "${HOME}/.zshrc"
  copy_config_file "${p10krc}" "${HOME}/.p10k.zsh"
}

function install_fnm {
  if ! command -v fnm >/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | bash
  else
    show_success "Fnm ya está instalado"
  fi

  if ! command -v node >/dev/null; then
    fnm install --lts
  else
    show_success "Node.js ya está instalado"
  fi
}

function set_lazyvim {
  show_header "setting lazyvim"

  if [ -d ~/.config/nvim ]; then

    # required
    mv ~/.config/nvim{,.bak}

    # optional but recommended
    mv ~/.local/share/nvim{,.bak}
    mv ~/.local/state/nvim{,.bak}
    mv ~/.cache/nvim{,.bak}
  fi
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
}

function install_wslu() {
	if ! command -v wslview ;then

  local tempdir
  tempdir="$(mktemp -d)"
  pushd "${tempdir}" >/dev/null || exit
  wget https://pkg.wslutiliti.es/public.key
  pacman-key --add public.key
  sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
  echo -e "\n[wslutilities]\nServer = https://pkg.wslutiliti.es/arch/" | sudo tee -a /etc/pacman.conf >/dev/null
  popd >/dev/null || exit
  sudo pacman -Sy
else 
	show_success "wslu already installed"
	fi
}

function install_deps {
  # local debian_deps="$DIR/packages/debian.list"
  show_header "Verificando dependencias"
  sudo pacman -S --noconfirm --needed \
    curl \
    wget \
    unzip \
    tar \
    neovim \
    lazygit \
    fd \
    ripgrep \
    zsh \
    wl-clipboard \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    zoxide \
    eza \
    wslu
}

# Función principal para instalar componentes en Debian WSL
function install_wsl() {
  install_wslu
  install_deps # Instalar dependencias necesarias
  install_fnm  # Instalar fnm y Node.js
  #set_zsh_shell_debian # Configurar Zsh como shell
  # Copiar archivo de configuración de Bash
  #copy_config_file "${bashrc}" "${HOME}/.bashrc"
  set_lazyvim
}

install_wsl # Llamar a la función principal para iniciar la instalación
