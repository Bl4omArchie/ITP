#!/bin/bash


# How can I verify my snort installation ?
#
# 1) snort -V
# 2) snort -c /path/to/snort.conf -T
# 3) which snort
#
# Should I add more security like include/ checking, config checking...


SNORT_NAME="snort"
LIBDAQ_NAME="daqtest"

check_snort_path() {
    which ${SNORT_NAME} || echo "Coudln't find snort in PATH"
}

check_libdaq_path() {
    which ${LIBDAQ_NAME} || echo "Coudln't find libdaq in PATH"
}
