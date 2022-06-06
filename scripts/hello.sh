#!/bin/bash

set -uo pipefail
set -e

readonly ME=${0##*/}

display_usage() {

    cat <<EOE

    Hello World!

    構文: ./${ME}

EOE

    exit

}

say_hello() {

    echo "Hello World!"

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

    say_hello

}

whoopsie() {

    local message=$1

    echo "${message} Aborting..."
    exit 192

}

main "$@"

exit 0
