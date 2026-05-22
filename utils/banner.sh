#!/bin/bash

source "$(dirname "$0")/utils/colors.sh" 2>/dev/null || source "$(dirname "$0")/colors.sh" 2>/dev/null

show_banner() {
    clear
    echo -e "${RED}"
    echo '  ███╗   ██╗██╗   ██╗██╗     ██╗     ██╗   ██╗'
    echo '  ████╗  ██║██║   ██║██║     ██║     ╚██╗ ██╔╝'
    echo '  ██╔██╗ ██║██║   ██║██║     ██║      ╚████╔╝ '
    echo '  ██║╚██╗██║██║   ██║██║     ██║       ╚██╔╝  '
    echo '  ██║ ╚████║╚██████╔╝███████╗███████╗   ██║   '
    echo '  ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝   '
    echo -e "${RESET}"
    echo -e "${DIM}${WHITE}        All-in-One Kali Linux Tools for Termux${RESET}"
    echo -e "${DIM}${RED}              By NullY | v1.0 | Termux Edition${RESET}"
    echo -e "${DIM}        ─────────────────────────────────────────${RESET}"
    echo ""
}

show_section() {
    echo -e "\n${BOLD}${CYAN}══════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${WHITE}  $1${RESET}"
    echo -e "${BOLD}${CYAN}══════════════════════════════════════════${RESET}\n"
}

print_ok()   { echo -e "${OK} $1"; }
print_err()  { echo -e "${ERR} $1"; }
print_info() { echo -e "${INFO} $1"; }
print_warn() { echo -e "${WARN} $1"; }
print_arrow(){ echo -e "${ARROW} $1"; }
