#!/bin/bash
# Download essential wordlists

install_wordlists() {
    show_section "Downloading Wordlists"

    local WL_DIR="$HOME/wordlists"
    mkdir -p "$WL_DIR"

    declare -A wordlists=(
        ["rockyou.txt.gz"]="https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt"
        ["common.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Common-Credentials/10-million-password-list-top-1000.txt"
        ["usernames.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Usernames/top-usernames-shortlist.txt"
        ["subdomains.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt"
        ["directories.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/directory-list-2.3-medium.txt"
        ["web-extensions.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/web-extensions.txt"
        ["LFI.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/LFI/LFI-Jhaddix.txt"
        ["SQLi.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/SQLi/Generic-SQLi.txt"
        ["XSS.txt"]="https://raw.githubusercontent.com/danielmiessler/SecLists/master/Fuzzing/XSS/XSS-Jhaddix.txt"
    )

    local total=${#wordlists[@]}
    local i=0

    for name in "${!wordlists[@]}"; do
        i=$(( i + 1 ))
        progress_bar "$i" "$total" "[$name]"
        wget -q --show-progress -O "$WL_DIR/$name" "${wordlists[$name]}" 2>/dev/null || \
        curl -s -L -o "$WL_DIR/$name" "${wordlists[$name]}" 2>/dev/null || true
    done
    echo ""

    # Decompress rockyou if needed
    if [ -f "$WL_DIR/rockyou.txt.gz" ]; then
        gunzip -f "$WL_DIR/rockyou.txt.gz" 2>/dev/null || true
    fi

    print_ok "Wordlists saved to: $WL_DIR"
}
