#!/bin/bash

set -euo pipefail

readonly ME=${0##*/}

display_usage() {

    cat <<EOE

    Loop example

    構文: ./${ME}

EOE

    exit

}

loop() {

    for VAL in 1 2 3; do
        echo "for step ${VAL}!!!"
    done

    # shellcheck disable=SC2044
    for FILE in $(find ./files -type f -name '*.txt'); do
        echo "${FILE##*/}"
    done

    local count=1

    while [ $count -lt 5 ]; do
        echo "while step ${count}!!!"
        count=$((count+1))
    done

}

main() {

    while getopts h opt; do
        case $opt in
            h)
                display_usage
            ;;
            \?)
                whoopsie "Invalid option!"
            ;;
        esac
    done

    loop

}

whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}

main "$@"

exit 0
