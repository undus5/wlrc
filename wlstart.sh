#!/usr/bin/bash

command -v fcitx5 &>/dev/null && \
    ! pidof fcitx5 &>/dev/null && fcitx5 -d -r

command -v lxqt-policykit-agent &>/dev/null && \
    ! pidof lxqt-policykit-agent &>/dev/null && \
        lxqt-policykit-agent 2>&1 &

command -v kanshi &>/dev/null && \
    ! pidof kanshi &>/dev/null && \
        kanshi 2>&1 &

