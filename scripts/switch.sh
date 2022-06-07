#!/bin/bash

set -euo pipefail

readonly ME=${0##*/}

display_usage() {

    cat <<EOE

    Switching example

    構文: ./${ME} -i <number>

EOE

    exit

}

switch() {

    local input=$1

    if [ "${input}" -eq 3 ]; then
        echo "Equal 3"
    elif [ "${input}" -gt 3 ]; then
        echo "Over 3"
    else
        echo "Under 3"
    fi

    set +u
    if [ -n "${NAME}" ]; then
        echo "Hello ${NAME}"
        if [ "${NAME}" = "Tom" ] && [ "${input}" != 3 ]; then
            echo "Good Bye!"
        fi
    fi
    set -u

}

main() {

    local input

    while getopts i:h opt; do
        case $opt in
            h)
                display_usage
            ;;
            i)
                input=$OPTARG
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    if [ -z "${input}" ]; then
        whoopsie "Please set -i <number>"
    fi

    if ! expr "${input}" : "[0-9]*$" >&/dev/null; then
        whoopsie "Please set -i <number>"
    fi

    switch "${input}"

}

whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}

main "$@"

exit 0
