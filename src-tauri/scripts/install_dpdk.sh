#!/bin/bash


# Script name : install_dpdk.sh
# Usage : ./install_dpdk.sh
# Description :
#   This script install DPDK
#
#
# Parameters :   
#
# Exemple :
#   ./install_dpdk.sh


source install.sh


dpdk_depedencies=('build-essential'      #dpdk requirements
                'python3' 
                'libnuma-dev' 
                'python3-pyelftools'
                'ninja-build'
                'meson')


set_default_env_var() {
    export $git_installation=${HOME}
    export $git_dpdk="${git_installation}/dpdk"
}


install_dpdk() {
    if ! git clone -q https://github.com/DPDK/dpdk; then
        echo -e "${RED}[✘] Error: couldn't get dpdk repository${NC}"
        exit 1
    fi

    cd ${git_dpdk}/build
    ninja
    sudo meson install
    ldconfig

    echo -e "${GREEN}[✔] DPDK installed!${NC}"
}


start_dpdk_installation() {    
    install_dependencies ${dpdk_depedencies[@]}
    set_default_env_var

    mkdir -p "${git_installation}" && cd "${git_installation}" || exit 1
    install_dpdk ${1}
}

parameters_checking() {
    if [[ $# -eq 1 ]]; then
        if ! [[ "${1}" =~ ^-?[0-9]+$ ]]; then
            echo "[!] Argument ${1} is meant to be an integer"
            exit 1
        elif [[ "${1}" -eq 0 ]]; then
            set -- "$(nproc)"
        fi
    else
        echo "[!] Invalid number of parameters"
        exit 1
    fi
}

select_package_manager
parameters_checking "$@"
start_dpdk_installation "$@"