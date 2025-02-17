#!/bin/bash


# Script name : install_snort.sh
# Usage : ./install_snort.sh <nprocs>
# Description :
#   This script install and verify Snort and its depedencies
#
#
# Parameters :
#   <int> : the number of processor your allocating for Snort installation. 
#   If you state 0, it will use the maximum processor available.     
#
# Exemple :
#   ./install_snort.sh 4


source install.sh


snort_required_packages=('cmake'            #snort requirements
                        'libdaq-dev' 
                        'libdnet-dev' 
                        'flex' 
                        'g++' 
                        'hwloc' 
                        'libluajit-5.1-dev' 
                        'libssl-dev' 
                        'libpcap-dev' 
                        'libpcre3-dev' 
                        'pkg-config'
                        'zlib1g-dev')


set_default_env_var() {
    export snort_path="/usr/local/snort"
    export libdaq_path="/usr/local/lib/daq_s3"
    export git_installation="${HOME}/snort3_install"
    export git_snort="${git_installation}/snort3"
    export git_libdaq="${git_installation}/libdaq"
}

install_snort() {
    if ! git clone -q https://github.com/snort3/snort3.git; then
        echo -e "${RED}[✘] Error: couldn't get Snort3 repository${NC}"
        exit 1
    fi
    
    cd "${git_snort}" || exit 1
    ./configure_cmake.sh --prefix="${snort_path}" --with-daq-includes="${libdaq_path}/include/" --with-daq-libraries="${libdaq_path}/lib/" &> /dev/null
    
    cd build || exit 1
    make -j "${1}" &> /dev/null
    sudo make install &> /dev/null

    echo -e "${GREEN}[✔] Snort3 installed!${NC}" 
}

install_libdaq() {
    if ! git clone -q https://github.com/snort3/libdaq.git; then
        echo -e "${RED}[✘] Error: couldn't get libdaq repository${NC}"
        exit 1
    fi
    cd "${git_libdaq}" || exit 1

    ./bootstrap &> /dev/null
    ./configure --prefix="${libdaq_path}" &> /dev/null

    make -j "${1}" &> /dev/null
    sudo make install &> /dev/null
    sudo ldconfig

    echo -e "${GREEN}[✔] Libdaq installed!${NC}"
}

start_snort_installation() {
    install_packages ${snort_required_packages[@]}
    set_default_env_var

    mkdir -p "${git_installation}" && cd "${git_installation}" || exit 1
    install_libdaq ${1}

    cd "${git_installation}" || exit 1
    install_snort ${1}
    
    export PATH=${libdaq_path}/bin:${PATH} >> ~/.bashrc
    export PATH=${snort_path}/bin:${PATH} >> ~/.bashrc
    source ~/.bashrc
    snort -V
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
start_snort_installation "$@"