#!/bin/bash
# Native Termux tools (no proot needed)

install_native_tools() {
    show_section "Installing Native Termux Tools"

    local tools=(
        # Core utilities
        curl wget git python python-pip ruby perl lua54 golang nodejs
        # Network tools
        nmap netcat-openbsd openssh openssl tsu iproute2 dnsutils
        # Dev tools
        cmake make clang clang++ binutils pkg-config
        # Text / utility
        vim nano tmux zsh fish htop tree file tar zip unzip p7zip
        # Database
        sqlite
        # Crypto
        gnupg2
        # Web
        php
        # Misc
        proot proot-distro termux-tools termux-api
        # Android extras
        tsu
    )

    local total=${#tools[@]}
    local i=0

    for tool in "${tools[@]}"; do
        i=$(( i + 1 ))
        progress_bar "$i" "$total" "[$tool]"
        pkg install -y "$tool" &>/dev/null 2>&1
    done
    echo ""

    # Python pip packages
    show_section "Installing Python Pip Packages"
    local pip_pkgs=(
        requests scapy impacket pwntools cryptography paramiko
        flask sqlalchemy colorama rich tqdm dnspython shodan
        beautifulsoup4 lxml pyOpenSSL pyserial
    )

    pip install --quiet --break-system-packages "${pip_pkgs[@]}" 2>/dev/null || \
    pip install --quiet "${pip_pkgs[@]}" 2>/dev/null

    print_ok "Native Termux tools installed."
}
