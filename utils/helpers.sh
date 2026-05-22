#!/bin/bash

source "$(dirname "$0")/utils/colors.sh" 2>/dev/null || source "$(dirname "$0")/colors.sh" 2>/dev/null

# Progress bar
progress_bar() {
    local current=$1
    local total=$2
    local label=$3
    local width=40
    local percent=$(( current * 100 / total ))
    local filled=$(( current * width / total ))
    local empty=$(( width - filled ))
    local bar=""
    for ((i=0; i<filled; i++)); do bar+="█"; done
    for ((i=0; i<empty; i++)); do bar+="░"; done
    printf "\r${CYAN}[${GREEN}%s${CYAN}]${RESET} %3d%% %s" "$bar" "$percent" "$label"
}

# Install a pkg silently with retry
pkg_install() {
    local pkg=$1
    pkg install -y "$pkg" &>/dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_ok "Installed: ${BOLD}$pkg${RESET}"
    else
        print_err "Failed:    ${BOLD}$pkg${RESET}"
    fi
}

# Run command inside Kali proot
kali_run() {
    proot-distro login kali -- bash -c "$1"
}

# Install Kali package inside proot
kali_pkg_install() {
    local pkg=$1
    print_arrow "Installing in Kali: ${BOLD}$pkg${RESET}"
    kali_run "DEBIAN_FRONTEND=noninteractive apt-get install -y $pkg" &>/dev/null 2>&1
    if [ $? -eq 0 ]; then
        print_ok "Kali installed: ${BOLD}$pkg${RESET}"
    else
        print_err "Kali failed:    ${BOLD}$pkg${RESET}"
    fi
}

# Check if command exists
cmd_exists() {
    command -v "$1" &>/dev/null
}

# Check if running in Termux
check_termux() {
    if [ -z "$TERMUX_VERSION" ] && [ ! -d "/data/data/com.termux" ]; then
        print_err "This script is designed for Termux on Android."
        exit 1
    fi
}

# Check storage permission
check_storage() {
    if [ ! -d "$HOME/storage" ]; then
        print_warn "Requesting storage permission..."
        termux-setup-storage
        sleep 2
    fi
}

# Spinner animation
spinner() {
    local pid=$1
    local msg=$2
    local spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        printf "\r${CYAN}${spin:$i:1}${RESET}  %s" "$msg"
        i=$(( (i+1) % ${#spin} ))
        sleep 0.1
    done
    printf "\r"
}
