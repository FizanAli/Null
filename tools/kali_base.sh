#!/bin/bash
# Setup Kali Linux proot environment

setup_kali_base() {
    show_section "Setting Up Kali Linux (proot-distro)"

    # Install proot-distro if not present
    if ! cmd_exists proot-distro; then
        print_arrow "Installing proot-distro..."
        pkg install -y proot-distro &>/dev/null 2>&1
    fi

    # Install Kali if not already done
    if ! proot-distro list | grep -q "kali.*installed"; then
        print_arrow "Downloading Kali Linux rootfs (this may take a while)..."
        proot-distro install kali
        print_ok "Kali Linux rootfs installed."
    else
        print_ok "Kali Linux already installed."
    fi

    # Bootstrap Kali inside proot
    print_arrow "Bootstrapping Kali apt..."
    kali_run "apt-get update -qq && apt-get upgrade -y -qq" &>/dev/null 2>&1
    kali_run "apt-get install -y -qq wget curl git nano python3 python3-pip" &>/dev/null 2>&1

    print_ok "Kali base ready."
}
