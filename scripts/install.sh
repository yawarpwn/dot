#!/bin/bash

DIR="$(dirname "$0")"
##
# Source the utils
##
. "$DIR"/utils.sh

function install_network {
  local networking="$DIR/packages/network.list"
  local nmconf="/etc/NetworkManager/NetworkManager.conf"
  local nmrandomconf="/etc/NetworkManager/conf.d/randomize_mac_address.conf"

  show_header "setting up networking."
  check_installed
  show_success "Networking aplications installed."
  check_installed "${networking}"

  show_info "Setting up MAC address randomization in Network Manager."
  if ! find "${nmconf}" /etc/NetworkManager/conf.d/ -type f -exec grep -q "mac-address=random" {} +; then
    sudo tee -a "${nmrandomconf}" >/dev/null <<EOF
[connection-mac-randomization]
wifi.cloned-mac-address=random
ethernet.cloned-mac-address=random
EOF
  fi

  show_info "Enabling NetworkManager service."
  sudo systemctl enable --now NetworkManager

  show_info "Disabling SSH root login and forcing SSH v2."
  sudo sed -i \
    -e "/^#PermitRootLogin prohibit-password$/a PermitRootLogin no" \
    -e "/^#Port 22$/i Protocol 2" \
    /etc/ssh/sshd_config

}

function install_fonts {
  local font_list="$DIR/packages/fonts.list"
  show_header "Installing fonts."
  check_installed "${font_list}"
  show_success "Fonts installed."

  show_info "Setting nerd font config."
  if ! [ -d /etc/fonts/conf.d ]; then
    show_warning "'/etc/fonts/conf.d' for fontconfig is missing. Skipping."
  elif ! [ -e /etc/fonts/conf.d/10-nerd-font-symbols.conf ]; then
    sudo ln -s \
      /usr/share/fontconfig/conf.avail/10-nerd-font-symbols.conf \
      /etc/fonts/conf.d/
  fi
}

function install_rust {
  show_info "Installing rust stable toolchain."
  rustup default stable

  show_info "Building local cache of cargo crates."
  local tmpdir
  tmpdir="$(mktemp -d)"
  git clone --depth 1 https://github.com/sudorook/crate_dl.git "${tmpdir}"
  pushd "${tmpdir}" >/dev/null || exit
  cargo fetch
  popd >/dev/null || exit
  rm -rf "${tmpdir}"
}

function install_printer() {
  local printer_list="$DIR"/packages/printer.list
  show_header "Installing CPUS and printer firmware."
  check_installed "${printer_list}"
  show_success "Printing applications installed."
  sudo systemctl enable --now cups

}

function install_essential() {
  local essential_list="$DIR/packages/essential.list"
  show_header "Installing essential packages."
  check_installed "${essential_list}"
  show_success "Essential packages installed."
}

function install_deps() {
  local dev_list="$DIR/packages/dev.list"
  show_header "Installing dependencies."
  check_installed "${dev_list}"

  # Install Bun
  if ! command -v bun >/dev/null; then
    curl -fsSL https://bun.sh/install | sh
  else
    show_success "bun already installed"
  fi

  #Install Fnm
  if ! command -v fnm >/dev/null; then
    curl -fsSL https://fnm.vercel.app/install | sh
  else
    show_success "fnm already installed"
  fi

  show_success "deps dependencies installed."
}

function install_aur_deps() {
  local dev_aur_list="$DIR/packages/dev-aur.list"
  show_header "Installing AUR dependencies."
  check_aur_installed "${dev_aur_list}"
  show_success "AUR dependencies installed."
}

function install_laptop {
  local laptop_list="${DIR}/packages/laptop.list"

  show_header "Installing laptop utilities."
  check_installed "${laptop_list}"
  show_success "Laptop utilities installed."

  # Enable tlp on laptops.
  show_info "Enabling and starting tlp systemd units."
  sudo systemctl enable tlp.service
  sudo systemctl start tlp.service
  show_success "tlp enabled."
}

function install_extras {
  echo "todo"
}

#TODO: Install openbox script

function main() {
  show_question "Select an option:"
  show_info "Main (Hit ENTER to see options again.)"
  local options=(
    "Quit"
    "Essential"
    "Dev"
    "Openbox")

  select option in "${options[@]}"; do
    case "${option}" in
    "Quit")
      show_success "I hope this was as fun for you as it was for me."
      break
      ;;
    "Essential")
      local response
      response=$(ask_question "Let this script install everything? (y/N)")
      if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        install_essential
      fi

      show_info "Main (Hit ENTER to see options again.)"
      ;;
    "Dev")
      local response
      response=$(ask_question "Let this script install everything? (y/N)")
      if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        install_deps
      fi

      show_info "Main (Hit ENTER to see options again.)"
      ;;
    "Openbox")
      echo "Base"
      ;;
    *)
      show_warning "Invalid option."
      ;;
    esac
  done

}

check_user
check_network

main
