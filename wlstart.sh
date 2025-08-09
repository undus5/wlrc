#!/usr/bin/bash

command -v fcitx5 &>/dev/null && \
    ! pidof fcitx5 &>/dev/null && fcitx5 -d -r

# polkit-gnome /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
command -v polkit-agent &>/dev/null && \
    ! pidof polkit-agent &>/dev/null && \
        polkit-agent 2>&1 &

command -v kanshi &>/dev/null && \
    ! pidof kanshi &>/dev/null && \
        kanshi 2>&1 &
