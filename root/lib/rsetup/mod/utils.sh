#!/bin/bash

readonly ERROR_REQUIRE_PARAMETER=-1
readonly ERROR_TOO_FEW_PARAMETERS=-2
readonly ERROR_REQUIRE_FILE=-3
readonly ERROR_ILLEGAL_PARAMETERS=-4

__require_parameter_check() {
    set -e
    
    if (( $# == 0 ))
    then
        echo "Incorrect usage of ${FUNCNAME[1]} from ${FUNCNAME[2]}: ${FUNCNAME[1]} requires parameter" >&2
        return $ERROR_REQUIRE_PARAMETER
    fi
    set +e
}

__parameter_count_check() {
    __require_parameter_check "$@"
    set -e
    
    local expected=$1
    shift 1
    if (( $# != $expected ))
    then
        echo "'${FUNCNAME[1]}' expects '$expected' parameters while getting $#: '$@'" >&2
        return $ERROR_TOO_FEW_PARAMETERS
    fi
    set +e
}

__assert_f() {
    __parameter_count_check 1 "$@"
    set -e

    if [[ ! -e "$1" ]]
    then
        echo "'${FUNCNAME[1]}' requires file '$1' to work!" >&2
        return $ERROR_REQUIRE_FILE
    fi
    set +e
}

__parameter_value_check() {
    __require_parameter_check "$@"
    set -e
    
    local option=$1
    shift 1
    local options=( "$@" )
    if [[ ! " ${options[*]} " =~ " $option " ]]; then
        echo "'${FUNCNAME[1]}' expects one of '${options[*]}', got '$option'" >&2
        return $ERROR_ILLEGAL_PARAMETERS
    fi
    set +e
}