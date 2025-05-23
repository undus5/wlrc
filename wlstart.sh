#!/usr/bin/bash

if command -v gsettings &>/dev/null; then
    [[ -d /usr/share/icons/Papirus ]] && \
        gsettings set org.gnome.desktop.interface icon-theme Papirus
    [[ -d /usr/share/themes/Adwaita-dark ]] && \
        gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
fi

command -v fcitx5 &>/dev/null && \
    ! pidof fcitx5 &>/dev/null && fcitx5 -d -r

command -v lxqt-policykit-agent &>/dev/null && \
    ! pidof lxqt-policykit-agent &>/dev/null && \
        lxqt-policykit-agent 2>&1 &

command -v kanshi &>/dev/null && \
    ! pidof kanshi &>/dev/null && \
        kanshi 2>&1 &

