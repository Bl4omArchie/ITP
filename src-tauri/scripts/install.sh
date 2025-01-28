#!/bin/bash


PKG_MANAGER="NULL"
INSTALL_CMD="NULL"


select_package_manager() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        case "$ID" in
            ubuntu|debian)
                PKG_MANAGER="apt"
                INSTALL_CMD="sudo apt update && sudo apt install -y"
                ;;
            fedora|centos|rhel)
                PKG_MANAGER="dnf"
                INSTALL_CMD="sudo dnf install -y"
                ;;
            arch)
                PKG_MANAGER="pacman"
                INSTALL_CMD="sudo pacman -S --noconfirm"
                ;;
            *)
                echo "Unsupported distribution: $ID"
                exit 1
                ;;
        esac
    else
        echo "Cannot detect distribution."
        exit 1
    fi
}


install_dependencies() {
    for package in "${@}"; do
        if ! dpkg -s "${package}" >/dev/null 2>&1; then
            $INSTALL_CMD "${package}" -y -qq
        fi
    done
    echo -e "${GREEN}[✔] Dependencies installed!${NC}"
}