#!/bin/bash
# Setup Kali Linux proot environment

setup_kali_base() {
    show_section "Setting Up Kali Linux (proot-distro)"

    # Install proot-distro if not present
    if ! cmd_exists proot-distro; then
        print_arrow "Installing proot-distro..."
        pkg install -y proot-distro
    fi

    # Install Kali if not already done
    if ! proot-distro list 2>/dev/null | grep -qi "kali"; then
        print_arrow "Downloading Kali Linux rootfs (this may take a while)..."
        proot-distro install kali
        print_ok "Kali Linux rootfs installed."
    else
        print_ok "Kali Linux already installed."
    fi

    # Ensure Kali repos point to kali-rolling and update package lists
    print_arrow "Configuring Kali repos and updating package lists..."
    proot-distro login kali -- bash -c "
        echo 'deb http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware' > /etc/apt/sources.list
        apt-get update -y
    " 2>&1 | tail -5

    # Install base packages
    print_arrow "Installing base packages inside Kali..."
    proot-distro login kali -- bash -c "
        DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing \
            wget curl git nano vim python3 python3-pip \
            build-essential net-tools iputils-ping dnsutils
    " 2>&1 | tail -3

    print_ok "Kali base ready."
}
