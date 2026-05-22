#!/bin/bash
# ┌──────────────────────────────────────────────────────┐
# │   NullY - All-in-One Kali Linux Tools for Termux     │
# │   One-click installer                                 │
# └──────────────────────────────────────────────────────┘

set -e

NULLY_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$NULLY_DIR/install.log"

# Source utilities
source "$NULLY_DIR/utils/colors.sh"
source "$NULLY_DIR/utils/banner.sh"
source "$NULLY_DIR/utils/helpers.sh"

# Source tool modules
source "$NULLY_DIR/tools/native.sh"
source "$NULLY_DIR/tools/kali_base.sh"
source "$NULLY_DIR/tools/kali_tools.sh"
source "$NULLY_DIR/tools/extra_tools.sh"
source "$NULLY_DIR/tools/wordlists.sh"

# Redirect all output also to log
exec > >(tee -a "$LOG_FILE") 2>&1

# ── Pre-flight checks ───────────────────────────────────────────────────────

preflight() {
    show_banner
    show_section "Pre-flight Checks"

    check_termux

    print_info "Termux version: ${TERMUX_VERSION:-unknown}"
    print_info "Home: $HOME"
    print_info "Log: $LOG_FILE"
    print_info "Install dir: $NULLY_DIR"

    check_storage

    # Confirm before proceeding
    echo ""
    echo -e "  ${YELLOW}This will install Kali Linux (proot) + ALL tools.${RESET}"
    echo -e "  ${YELLOW}Required space: ~8-15 GB | Time: 30-90 min (WiFi recommended)${RESET}"
    echo ""
    read -p "$(echo -e ${BOLD}${CYAN}  Proceed? [Y/n]:${RESET} )" confirm
    [[ "$confirm" =~ ^[Nn]$ ]] && echo "Aborted." && exit 0
}

# ── Step 1: Update Termux ───────────────────────────────────────────────────

step_update_termux() {
    show_section "Step 1/6 — Updating Termux"
    pkg update -y &>/dev/null 2>&1
    pkg upgrade -y &>/dev/null 2>&1
    print_ok "Termux packages updated."
}

# ── Step 2: Native Termux tools ─────────────────────────────────────────────

step_native() {
    show_section "Step 2/6 — Native Termux Tools"
    install_native_tools
}

# ── Step 3: Kali Linux proot base ──────────────────────────────────────────

step_kali_base() {
    show_section "Step 3/6 — Kali Linux Base"
    setup_kali_base
}

# ── Step 4: Kali tool categories ───────────────────────────────────────────

step_kali_tools() {
    show_section "Step 4/6 — Kali Tool Categories"
    install_kali_tools
}

# ── Step 5: Extra GitHub tools ─────────────────────────────────────────────

step_extra() {
    show_section "Step 5/6 — Extra GitHub Tools"
    install_extra_tools
}

# ── Step 6: Wordlists ──────────────────────────────────────────────────────

step_wordlists() {
    show_section "Step 6/6 — Wordlists"
    install_wordlists
}

# ── Post-install: create shortcut ──────────────────────────────────────────

post_install() {
    show_section "Finalizing Installation"

    # Make all scripts executable
    chmod +x "$NULLY_DIR/nully.sh"
    chmod +x "$NULLY_DIR/install.sh"
    chmod +x "$NULLY_DIR/utils/"*.sh
    chmod +x "$NULLY_DIR/tools/"*.sh

    # Create global shortcut: just type 'nully' anywhere
    local bin_dir="$PREFIX/bin"
    mkdir -p "$bin_dir"
    cat > "$bin_dir/nully" <<EOF
#!/bin/bash
bash "$NULLY_DIR/nully.sh" "\$@"
EOF
    chmod +x "$bin_dir/nully"

    # Also create a Kali shortcut
    cat > "$bin_dir/kali" <<EOF
#!/bin/bash
proot-distro login kali
EOF
    chmod +x "$bin_dir/kali"

    # Show completion banner
    clear
    echo -e "${RED}"
    echo '  ███╗   ██╗██╗   ██╗██╗     ██╗     ██╗   ██╗'
    echo '  ████╗  ██║██║   ██║██║     ██║     ╚██╗ ██╔╝'
    echo '  ██╔██╗ ██║██║   ██║██║     ██║      ╚████╔╝ '
    echo '  ██║╚██╗██║██║   ██║██║     ██║       ╚██╔╝  '
    echo '  ██║ ╚████║╚██████╔╝███████╗███████╗   ██║   '
    echo '  ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝   ╚═╝   '
    echo -e "${RESET}"
    echo -e "${GREEN}  ✔ Installation Complete!${RESET}"
    echo ""
    echo -e "  ${BOLD}${WHITE}Commands:${RESET}"
    echo -e "  ${CYAN}nully${RESET}          — Launch NullY menu"
    echo -e "  ${CYAN}kali${RESET}           — Enter Kali Linux shell"
    echo -e "  ${CYAN}bash install.sh${RESET} — Re-run installer"
    echo ""
    echo -e "  ${DIM}Tools: $HOME/nully-tools${RESET}"
    echo -e "  ${DIM}Wordlists: $HOME/wordlists${RESET}"
    echo -e "  ${DIM}Log: $LOG_FILE${RESET}"
    echo ""
    echo -e "  ${YELLOW}Type 'nully' to start!${RESET}"
    echo ""
}

# ── Main ────────────────────────────────────────────────────────────────────

main() {
    preflight
    step_update_termux
    step_native
    step_kali_base
    step_kali_tools
    step_extra
    step_wordlists
    post_install
}

main "$@"
