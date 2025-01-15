#!/bin/bash

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


set_env_var() {
    export snort_path="/usr/local/snort"
    export libdaq_path="/usr/local/lib/daq_s3"
}

is_already_installed() {
    return 0
}

install_depedencies() {
    for i in $1
    do
        if ! dpkg -s "${i}" >/dev/null 2>&1; then
            sudo apt install "${i}" -y -qq
        fi
    done
    echo -e "${GREEN}[✔] Depedencies installed !${NC}"
}

install_snort() {
    if ! git clone -q https://github.com/snort3/snort3.git; then
        echo -e "${RED}[✘] Error : couldn't get snort3 repository${NC}"
        exit
    fi
    cd snort3 || exit
    ./configure_cmake.sh --prefix="${snort_path}" --with-daq-includes="${libdaq_path}"/include/ --with-daq-libraries="${libdaq_path}"/lib/
    cd build
    make -j $(( $(nproc) / 2 )) -s
    sudo make install -s
    sudo ldconfig
    echo -e "${GREEN}[✔] Snort3 installed !${NC}" 
}

install_libdaq() {
    if ! git clone -q https://github.com/snort3/libdaq.git; then
        echo -e "${RED}[✘] Error : couldn't get libdaq repository${NC}"
        exit
    fi
    cd libdaq || exit
    ./bootstrap
    ./configure
    make -j $(( $(nproc) / 2 )) -s
    sudo make install -s
    ./configure
    make -j $(( $(nproc) / 2 )) -s
    sudo make install -s
    echo -e "${GREEN}[✔] Libdaq installed !${NC}" 
}

start_snort_installation() {
    if ! is_already_installed; then
        echo "Snort already installed"
        exit
    fi
    
    install_depedencies "$snort_required_packages"
    set_env_var

    mkdir ~/snort_src && cd ~/snort_src
    install_libdaq

    cd ~/snort_src
    install_snort
    snort -V
}

start_snort_installation