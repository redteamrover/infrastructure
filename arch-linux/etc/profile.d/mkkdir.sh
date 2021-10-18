#! /usr/bin/bash
#
# mkkdir version 1.5.1
#
# Create a new directory and move into it in the same
# command.
#
# If the specified directory already exists, the command
# will fail, as the assumption is that the directory is
# meant to be new.
#
# Error Codes:
#
#  Note: Error codes do not include the number one, since
#        that is a common error code. We want the user to
#        intuitively gather that the specific status code
#        means something specific, so we skip the number
#        one and begin with two.
#
#  2 - USAGE_ERROR
#  3 - INVALID_ARGUMENT
#  4 - DIRECTORY_EXISTS
#
function mkkdir() {
    # We begin by checking for the command-line argument
    # passed in by the user. It must be exactly one, since
    # we can only create and change into one directory, and
    # all of the valid program options result in short-
    # circuiting program execution.
    #
    if [[ $# -ne 1 ]]; then
        # Since the number of command-line arguments was
        # not exactly one, notify the user of their error
        # and return with an error status code.
        echo 'Usage: mkkdir <DirectoryPath>' >&2

        # Return USAGE_ERROR status code.
        return 2
    fi

    # Check whether the user requested the version number
    # of the program or the help menu. 
    case $1 in
        -h | --help)
            echo 'Usage: mkkdir <DirectoryPath>'
            echo 'Create new directory and cd to it'
            echo ''
            echo '  -h, --help     display this help and exit'
            echo '      --version  output version information and exit'
            echo ''
            echo 'Copyright (C) 2021 Jose Fernando Lopez Fernandez'
            echo 'License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.'
            echo 'This is free software: you are free to change and redistribute it.'
            echo 'There is NO WARRANTY, to the extent permitted by law.'
            return 0
            ;;

        --version)
            echo 'mkkdir version 1.5.1'
            echo 'Written by Jose Fernando Lopez Fernandez <josefernando.lopezfernandez@snhu.edu>.'
            return 0
            ;;

    # Check for invalid options. This function will thus
    # not be able to create directories that begin with a
    # hyphen, but that's so uncommon so as to be totally
    # fine.
    #
    # Usually an argument that begins with a hyphen
    # detected here will almost always be a mispelled
    # command-line option.
        -*)
            echo "Invalid option detected: $1"
            return 3
            ;;
    esac

    # Passing in an empty string to the function will not
    # trigger any errors so far, since an argument was
    # technically passed in. Still, this edge case is
    # obviously not a valid use case, and we must therefore
    # validate the input string.
    if [[ -z "$1" ]]; then
        # The input string is a zero-length string, so we
        # simply let the user know and exit with an error
        # status.
        echo 'The empty string is an invalid directory path.' >&2

        # Since this is technically also a case of an
        # invalid argument, we return the same error code
        # as above.
        return 3
    fi
    
    # Check whether the specified directory exists. If it
    # does, return with an error status.
    if [[ -d "$1" ]]; then
        # The directory exists so simply let the user know
        # and exit with an error status.
        echo "The specified directory already exists: $1" >&2

        # Return the DIRECTORY_EXISTS error code.
        return 4
    fi

    # Finally, create the directory and change the current
    # working directory to it using the cd command.
    mkdir -p "$1" && cd "$1"
}

