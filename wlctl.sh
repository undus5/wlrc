#!/usr/bin/bash

set -e

printferr() {
    printf "${@}" >&2 && exit 1
}

#################################################################################
# volume control
# https://wiki.archlinux.org/title/WirePlumber
#################################################################################

wpctl-check() {
    command -v wpctl &>/dev/null || printferr "command not found: wpctl\n"
}

vol-get() {
    wpctl-check
    local _id=${1}
    local _info=$(wpctl get-volume ${_id})
    local _integer=$(echo "${_info}" | awk -F'[. ]' '{ print $2 }')
    local _fraction=$(echo "${_info}" | awk -F'[. ]' '{ print $3 }')
    local _muted=$(echo "${_info}" | awk -F'[. ]' '{ print $4 }')
    local _label=""

    if [[ "${_muted}" == "[MUTED]" ]]; then
        _label=${_muted}
    else
        [[ "${_integer}" == "1" ]] && _label="100%" || _label="${_fraction}%"
    fi
    echo "${_label}"
}

vol-num() {
    wpctl-check
    [[ "${1}" == "[MUTED]" ]] && echo "103" || echo "${1:0:-1}"
}

vol-down() {
    wpctl-check
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    wobctl.sh "$(vol-num $(vol-get @DEFAULT_AUDIO_SINK@))"
}

vol-up() {
    wpctl-check
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    wobctl.sh "$(vol-num $(vol-get @DEFAULT_AUDIO_SINK@))"
}

mute-toggle-speaker() {
    wpctl-check
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    wobctl.sh "$(vol-num $(vol-get @DEFAULT_AUDIO_SINK@))"
}

mute-toggle-mic() {
    wpctl-check
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
}

#################################################################################
# sway status
#################################################################################

muted-label() {
    wpctl-check
    local _label
    local _vol

    _vol="$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)"
    [[ "${_vol}" =~ MUTED ]] && _label="${_label}M"
    _vol="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
    [[ "${_vol}" =~ MUTED ]] && _label="${_label}S"

    [[ -n "${_label}" ]] && echo "[Muted:${_label}] " || echo ""
}

bar-status() {
    local _str
    while true; do
        _str=""
        _str+="$(muted-label)"
        _str="${_str}$(date '+%a %b %d %H:%M')"
        printf "%s \n" "${_str}"
        sleep 0.1
    done
}

#################################################################################
# lock screen, suspend
#################################################################################

lock-screen() {
    command -v swaylock &>/dev/null || printferr "command not found: swaylock\n"
    pidof swaylock || swaylock \
        --daemonize \
        --ignore-empty-password \
        --indicator-idle-visible \
        --indicator-radius 50 \
        --indicator-thickness 13 \
        --indicator-x-position 80 \
        --indicator-y-position 80 \
        --color 000000 \
        --scaling solid_color
}

lock-suspend() {
    lock-screen
    sleep 0.2
    systemctl suspend
}

#################################################################################
# screenshot
# https://github.com/OctopusET/sway-contrib
#################################################################################

grim-check() {
    command -v grim &>/dev/null || printferr "command not found: grim\n"
}

grimshot-check() {
    command -v grimshot &>/dev/null || printferr "command not found: grimshot\n"
}

_save_path=~/Pictures/Screenshot.$(date +%y%m%d.%H%M%S).$(date +%N|cut -c1).png

screenshot-full() {
    grim-check
    grim ${_save_path}
}

screenshot-area() {
    grim-check && grimshot-check
    grimshot savecopy area ${_save_path}
}

screenshot-window() {
    grim-check && grimshot-check
    grimshot savecopy window ${_save_path}
}

#################################################################################
# dispatcher
#################################################################################

case "${1}" in
    "")
        printf "Usage: $(basename $0) <function_name>\n"
        printf "function_name:\n"
        declare -F | awk '{print "  " $3}'
        ;;
    *)
        _command="${1}"
        shift
        ${_command} "${@}"
        ;;
esac

