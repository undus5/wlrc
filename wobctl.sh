#!/usr/bin/bash

# https://github.com/francma/wob
# https://gitlab.com/wef/dotfiles/-/blob/master/bin/mywob

print-help() {
    printf "Usage: $(basename $0) <integer>\n"
}

case "$1" in
    "")
        print-help
        exit 1
        ;;
    -h|--help)
        print-help
        exit 0
        ;;
esac

_wob_pipe=~/.cache/$( basename "$SWAYSOCK" ).wob
_status="false"
_wob_swaysock=""

[[ "$SWAYSOCK" ]] || (command -v wob &>/dev/null) || exit 0
[[ "${1}" ]] && [[ "${1}" =~ ^[0-9]{1,3}$ ]] || exit 0

for pid in $( pgrep -u "$USER" "^wob$" ); do
    _wob_swaysock="$( tr '\0' '\n' < "/proc/$pid/environ" | awk -F'=' '/^SWAYSOCK/ {print $2}' )"
    if [[ "${_wob_swaysock}" == "$SWAYSOCK" ]]; then
        _status="true"
    fi
done

[[ -p ${_wob_pipe} ]] || mkfifo "${_wob_pipe}"

[[ "${_status}" == "false" ]] && tail -f ${_wob_pipe} | wob &

echo "${1}" > ${_wob_pipe}

