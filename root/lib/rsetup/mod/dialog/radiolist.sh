#!/bin/bash

source "$ROOT_PATH/lib/rsetup/mod/dialog/basic.sh"

RSETUP_RADIOLIST=()
RSETUP_RADIOLIST_STATE_OLD=()
RSETUP_RADIOLIST_STATE_NEW=()

radiolist_init() {
    __parameter_count_check 0 "$@"

    RSETUP_RADIOLIST=()
    RSETUP_RADIOLIST_STATE_OLD=()
    RSETUP_RADIOLIST_STATE_NEW=()
}

radiolist_add() {
    __parameter_count_check 2 "$@"

    local item=$1
    local status=$2
    local tag="$((${#RSETUP_RADIOLIST[@]} / 3))"

    __parameter_value_check "$status" "ON" "OFF"

    RSETUP_RADIOLIST+=( "$tag" "$item" "$status" )

    if [[ $status == "ON" ]]
    then
        RSETUP_RADIOLIST_STATE_OLD+=( "$tag" )
    fi
}

radiolist_show() {
    __parameter_count_check 1 "$@"

    RSETUP_RADIOLIST_STATE_NEW=( "$(__dialog --radiolist "$1" "${RSETUP_RADIOLIST[@]}" 3>&1 1>&2 2>&3 3>&-)" )
}