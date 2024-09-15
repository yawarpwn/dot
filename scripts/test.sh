#!/bin/bash

DIR="$(dirname "$0")"
##
# Source the utils
##
. "$DIR"/utils.sh

function install_network {
  local network_packages=(networkmanager networkmanager-openvpn openssh wireguard-tools)
  local nm_conf="/etc/NetworkManager/NetworkManager.conf"

  show_header "setting up networking."
  show_success "Networking aplications installed."

}

install_network
