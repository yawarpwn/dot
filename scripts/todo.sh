function install_openbox {
  local cinnamon="${DIR}/packages/cinnamon.list"
  local lightdmconf="/etc/lightdm/lightdm.conf"
  local gammastepini="${DIR}/configs/gammastep.ini"
  local xdgdefaultconf="/etc/xdg/user-dirs.defaults"

  show_header "Setting up cinnamon desktop environment."
  check_installed "${cinnamon}"
  show_success "Cinnamon installed."

  if ! test ${DESKTOP_SESSION+x}; then
    export DESKTOP_SESSION="cinnamon"
  fi

  show_info "Setting up LightDM greeter."
  sudo sed -i \
    "s/^#greeter-hide-users=false/greeter-hide-users=false/g" \
    "${lightdmconf}"
  sudo sed -i \
    "s/^#greeter-session=.*/greeter-session=lightdm-gtk-greeter/g" \
    "${lightdmconf}"

  if [ -f /etc/systemd/system/display-manager.service ]; then
    if [[ "$(systemctl is-active lightdm)" = inactive ]]; then
      local display_manager
      display_manager="$(readlink -f /etc/systemd/system/display-manager.service)"
      display_manager="${display_manager##*/}"
      show_warning "Display manager already set to ${display_manager@Q}. Skipping LightDM."
    fi
  else
    sudo systemctl enable lightdm.service
  fi

  # Get latitude and longitude using GeoClue2 for Gammastep.
  show_info "Setting Gammastep config."
  if [ -e /usr/lib/geoclue-2.0/demos/where-am-i ]; then
    mkdir -p "${HOME}/.config/gammastep"
    local tmp
    local lat
    local lon
    if tmp="$(/usr/lib/geoclue-2.0/demos/where-am-i -t 10 -a 4)"; then
      lat="$(echo "${tmp}" | sed -n "s/.*Latitude: \+\([-0-9\.]\+\)°\?.*/\1/p")"
      lon="$(echo "${tmp}" | sed -n "s/.*Longitude: \+\([-0-9\.]\+\)°\?.*/\1/p")"
      sed -e "s,^lat=.*,lat=${lat},g" -e "s,^lon=.*,lon=${lon},g" \
        "${gammastepini}" >"${HOME}/.config/gammastep/config.ini"
    else
      show_warning "Parsing latitude/longitude failed. Defaulting to NYC."
      cp "${gammastepini}" "${HOME}/.config/gammastep/config.ini"
    fi
  else
    show_warning "Geoclue 'where-am-i' demo not found. Defaulting to NYC."
    cp "${gammastepini}" "${HOME}/.config/gammastep/config.ini"
  fi

  show_info "Setting kitty as default terminal."
  gsettings set org.cinnamon.desktop.default-applications.terminal exec 'kitty'

  show_info "Creating Projects/ and Sync/ and setting gvfs icon metadata."
  mkdir -p "${HOME}/Projects"
  mkdir -p "${HOME}/Sync"
  gio set "${HOME}/Projects/" -t string metadata::custom-icon-name folder-development
  gio set "${HOME}/Sync/" -t string metadata::custom-icon-name folder-cloud

  show_info "Disabling Templates/ and Public/ directories."
  sudo sed -i "s/^TEMPLATES/#TEMPLATES/g" "${xdgdefaultconf}"
  sudo sed -i "s/^PUBLICSHARE/#PUBLICSHARE/g" "${xdgdefaultconf}"
  [ -d "${HOME}/Templates" ] && rmdir --ignore-fail-on-non-empty "${HOME}/Templates"
  [ -d "${HOME}/Public" ] && rmdir --ignore-fail-on-non-empty "${HOME}/Public"
  xdg-user-dirs-update
}

function set_lightdm_theme {
  local lightdmgtkconf="/etc/lightdm/lightdm-gtk-greeter.conf"
  if pacman -Qi lightdm-gtk-greeter >/dev/null 2>&1; then
    show_header "Setting LightDM login GTK theme to ${GTKTHEME@Q}."
    sudo sed -i "s/^#theme-name=$/theme-name=/g" ${lightdmgtkconf}
    sudo sed -i "s/^theme-name=.*/theme-name=${GTKTHEME}/g" ${lightdmgtkconf}
    sudo sed -i "s/^#icon-theme-name=$/icon-theme-name=/g" ${lightdmgtkconf}
    sudo sed -i "s/^icon-theme-name=.*$/icon-theme-name=${ICONTHEME}/g" ${lightdmgtkconf}
    if [[ "${FONT}" == "Noto" ]]; then
      if pacman -Qi noto-fonts >/dev/null 2>&1; then
        sudo sed -i "s/^#font-name=$/font-name=/g" ${lightdmgtkconf}
        sudo sed -i "s/^font-name=.*/font-name=Noto Sans/g" ${lightdmgtkconf}
      fi
    elif [[ "${FONT}" == "Roboto" ]]; then
      if pacman -Qi ttf-roboto >/dev/null 2>&1; then
        sudo sed -i "s/^#font-name=$/font-name=/g" ${lightdmgtkconf}
        sudo sed -i "s/^font-name=.*/font-name=Roboto/g" ${lightdmgtkconf}
      fi
    fi
    sudo sed -i "s/^#xft-hintstyle=$/xft-hintstyle=/g" ${lightdmgtkconf}
    sudo sed -i "s/^xft-hintstyle=.*$/xft-hintstyle=slight/g" ${lightdmgtkconf}
  else
    show_warning "LightDM GTK greeter not installed. Skipping."
  fi
}
