#!/bin/bash


# How can I verify my snort installation ?
#
# 1) snort -V
# 2) snort -c /path/to/snort.conf -T
# 3) which snort
#
# Should I add more security like include/ checking, config checking...


check_snort() {
    if [ -z "${snort_path}" ]; then
        echo "Couldn't find Snort3 environment variable"
        exit 1
    elif [ ! -d "${snort_path}" ]; then
        echo "Snort folder is empty"
        exit 1
    echo 
    fi
}

check_libdaq() {
    if [ -z "${libdaq_path}" ]; then 
        echo "Couldn't find libdaq"
        exit 1
    fi
}

check_git_snort() {
    if [ -z "${git_snort}" ]; then 
        echo "Couldn't find git Snort3"
        exit 1
    fi
}

check_git_libdaq() {
    if [ -z "${git_libdaq}" ]; then 
        echo "Couldn't find git libdaq"
        exit 1
    fi
}