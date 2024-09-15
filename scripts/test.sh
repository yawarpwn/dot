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
