#!/bin/bash
# Extra tools cloned from GitHub (run inside native Termux)

install_extra_tools() {
    show_section "Installing Extra GitHub Tools"

    local TOOLS_DIR="$HOME/nully-tools"
    mkdir -p "$TOOLS_DIR"

    declare -A gh_tools=(
        ["sqlmap"]="https://github.com/sqlmapproject/sqlmap"
        ["exploitdb"]="https://github.com/offensive-security/exploitdb"
        ["SecLists"]="https://github.com/danielmiessler/SecLists"
        ["PayloadsAllTheThings"]="https://github.com/swisskyrepo/PayloadsAllTheThings"
        ["LinEnum"]="https://github.com/rebootuser/LinEnum"
        ["linux-smart-enumeration"]="https://github.com/diego-treitos/linux-smart-enumeration"
        ["pwncat"]="https://github.com/calebstewart/pwncat"
        ["LaZagne"]="https://github.com/AlessandroZ/LaZagne"
        ["Striker"]="https://github.com/s0md3v/Striker"
        ["XSStrike"]="https://github.com/s0md3v/XSStrike"
        ["Arjun"]="https://github.com/s0md3v/Arjun"
        ["Photon"]="https://github.com/s0md3v/Photon"
        ["RED_HAWK"]="https://github.com/Tuhinshubhra/RED_HAWK"
        ["FinalRecon"]="https://github.com/thewhiteh4t/FinalRecon"
        ["ReconDog"]="https://github.com/s0md3v/ReconDog"
        ["theHarvester"]="https://github.com/laramies/theHarvester"
        ["DNSx"]="https://github.com/projectdiscovery/dnsx"
        ["Nuclei"]="https://github.com/projectdiscovery/nuclei"
        ["naabu"]="https://github.com/projectdiscovery/naabu"
        ["httpx"]="https://github.com/projectdiscovery/httpx"
        ["subfinder"]="https://github.com/projectdiscovery/subfinder"
        ["katana"]="https://github.com/projectdiscovery/katana"
        ["PhoneSploit"]="https://github.com/AzeemIdrisi/PhoneSploit-Pro"
        ["SocialFish"]="https://github.com/UndeadSec/SocialFish"
        ["zphisher"]="https://github.com/htr-tech/zphisher"
        ["seeker"]="https://github.com/thewhiteh4t/seeker"
        ["camphish"]="https://github.com/htr-tech/camphish"
        ["nexphisher"]="https://github.com/htr-tech/nexphisher"
        ["Cr3dOv3r"]="https://github.com/D4Vinci/Cr3dOv3r"
        ["websploit"]="https://github.com/websploit/websploit"
        ["CredSniper"]="https://github.com/ustayready/CredSniper"
        ["bettercap"]="https://github.com/bettercap/bettercap"
        ["fsociety"]="https://github.com/Manisso/fsociety"
        ["hackingtool"]="https://github.com/Z4nzu/hackingtool"
        ["BruteDum"]="https://github.com/anki-code/BruteDum"
    )

    local total=${#gh_tools[@]}
    local i=0

    for name in "${!gh_tools[@]}"; do
        i=$(( i + 1 ))
        local url="${gh_tools[$name]}"
        local dest="$TOOLS_DIR/$name"
        progress_bar "$i" "$total" "[$name]"
        if [ ! -d "$dest" ]; then
            git clone --depth=1 --quiet "$url" "$dest" 2>/dev/null || true
        fi
    done
    echo ""

    # Install pip requirements for Python tools
    print_arrow "Installing pip requirements for extra tools..."
    for dir in "$TOOLS_DIR"/*/; do
        if [ -f "$dir/requirements.txt" ]; then
            pip install --quiet --break-system-packages -r "$dir/requirements.txt" 2>/dev/null || \
            pip install --quiet -r "$dir/requirements.txt" 2>/dev/null || true
        fi
    done

    print_ok "Extra GitHub tools installed to: $TOOLS_DIR"
}
