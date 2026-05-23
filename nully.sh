#!/bin/bash
# NullY - Main launcher/menu

NULLY_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$NULLY_DIR/utils/colors.sh"
source "$NULLY_DIR/utils/banner.sh"

TOOLS_DIR="$HOME/nully-tools"
WL_DIR="$HOME/wordlists"

# ── Menu helpers ────────────────────────────────────────────────────────────

print_menu_item() {
    printf "  ${BOLD}${CYAN}[%2s]${RESET} ${WHITE}%-28s${RESET} ${DIM}%s${RESET}\n" "$1" "$2" "$3"
}

print_divider() {
    echo -e "  ${DIM}────────────────────────────────────────────────────${RESET}"
}

# ── Launch helpers ──────────────────────────────────────────────────────────

launch_kali() {
    local KALI_ROOTFS="$PREFIX/var/lib/proot-distro/installed-rootfs/kali"
    if [ ! -d "$KALI_ROOTFS" ]; then
        echo -e "\n${RED}Kali Linux is not installed yet.${RESET}"
        echo -e "${YELLOW}Run: bash ~/NullY/install.sh${RESET}\n"
        read -p "Press Enter to continue..."
        return 1
    fi
    echo -e "\n${GREEN}Entering Kali Linux shell...${RESET}\n"
    proot-distro login kali
}

launch_tool() {
    local dir="$TOOLS_DIR/$1"
    local cmd="$2"
    if [ -d "$dir" ]; then
        cd "$dir" && bash -c "$cmd"
        cd "$NULLY_DIR"
    else
        print_err "Tool '$1' not found in $TOOLS_DIR. Run install.sh first."
    fi
}

open_wordlists() {
    echo -e "\n${CYAN}Wordlists directory:${RESET} $WL_DIR\n"
    ls -lh "$WL_DIR" 2>/dev/null || echo "No wordlists found. Run install.sh first."
    echo ""
    read -p "Press Enter to continue..."
}

# ── Sub-menus ───────────────────────────────────────────────────────────────

menu_recon() {
    while true; do
        show_banner
        show_section "Information Gathering"
        print_menu_item  1 "nmap"              "Port scanner"
        print_menu_item  2 "masscan"           "Fast port scanner"
        print_menu_item  3 "theHarvester"      "OSINT harvester"
        print_menu_item  4 "Recon-Dog"         "Reconnaissance tool"
        print_menu_item  5 "FinalRecon"        "Web recon"
        print_menu_item  6 "Photon"            "Web crawler / OSINT"
        print_menu_item  7 "subfinder"         "Subdomain discovery"
        print_menu_item  8 "Amass (Kali)"      "Advanced OSINT recon"
        print_menu_item  9 "dnsx (Kali)"       "DNS toolkit"
        print_menu_item 10 "enum4linux (Kali)" "SMB enumeration"
        print_divider
        print_menu_item  0 "Back"              ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1) launch_kali ;;
            2) launch_kali ;;
            3) launch_tool "theHarvester" "python3 theHarvester.py -h" ;;
            4) launch_tool "ReconDog" "python3 ReconDog.py" ;;
            5) launch_tool "FinalRecon" "python3 finalrecon.py --help" ;;
            6) launch_tool "Photon" "python3 photon.py --help" ;;
            7) launch_tool "subfinder" "./subfinder --help 2>/dev/null || python3 main.go --help" ;;
            8|9|10) launch_kali ;;
            0) break ;;
        esac
    done
}

menu_web() {
    while true; do
        show_banner
        show_section "Web Application Tools"
        print_menu_item  1 "sqlmap"      "SQL injection tool"
        print_menu_item  2 "XSStrike"   "XSS scanner"
        print_menu_item  3 "Arjun"      "Parameter discovery"
        print_menu_item  4 "Striker"    "Advanced web scanner"
        print_menu_item  5 "gobuster"   "Dir/file brute force (Kali)"
        print_menu_item  6 "ffuf"       "Fuzzer (Kali)"
        print_menu_item  7 "nikto"      "Web server scanner (Kali)"
        print_menu_item  8 "wpscan"     "WordPress scanner (Kali)"
        print_menu_item  9 "Burp Suite" "Web proxy (Kali)"
        print_menu_item 10 "Nuclei"     "Vulnerability scanner"
        print_divider
        print_menu_item  0 "Back"       ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1) launch_tool "sqlmap"     "python3 sqlmap.py --wizard" ;;
            2) launch_tool "XSStrike"  "python3 xsstrike.py --help" ;;
            3) launch_tool "Arjun"     "python3 arjun.py --help" ;;
            4) launch_tool "Striker"   "python3 striker.py" ;;
            5|6|7|8|9) launch_kali ;;
            10) launch_tool "nuclei" "./nuclei --help 2>/dev/null" ;;
            0) break ;;
        esac
    done
}

menu_exploit() {
    while true; do
        show_banner
        show_section "Exploitation Tools"
        print_menu_item 1 "Metasploit"    "Framework (Kali)"
        print_menu_item 2 "searchsploit"  "Exploit-DB search (Kali)"
        print_menu_item 3 "BeEF"          "Browser exploitation (Kali)"
        print_menu_item 4 "Responder"     "LLMNR/NBT-NS poison (Kali)"
        print_menu_item 5 "Evil-WinRM"    "WinRM shell (Kali)"
        print_menu_item 6 "CrackMapExec"  "Network attacks (Kali)"
        print_menu_item 7 "PhoneSploit"   "ADB exploitation"
        print_menu_item 8 "websploit"     "Web/network exploit"
        print_divider
        print_menu_item 0 "Back"          ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1|2|3|4|5|6) launch_kali ;;
            7) launch_tool "PhoneSploit" "python3 phoneXploit.py" ;;
            8) launch_tool "websploit"  "python3 websploit.py" ;;
            0) break ;;
        esac
    done
}

menu_password() {
    while true; do
        show_banner
        show_section "Password Attack Tools"
        print_menu_item 1 "hashcat"     "GPU hash cracker (Kali)"
        print_menu_item 2 "john"        "John the Ripper (Kali)"
        print_menu_item 3 "hydra"       "Online brute forcer (Kali)"
        print_menu_item 4 "medusa"      "Parallel brute forcer (Kali)"
        print_menu_item 5 "BruteDum"    "SSH/FTP/Telnet brute"
        print_menu_item 6 "crunch"      "Wordlist generator (Kali)"
        print_menu_item 7 "Open WLists" "Browse wordlists"
        print_divider
        print_menu_item 0 "Back"        ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1|2|3|4|6) launch_kali ;;
            5) launch_tool "BruteDum" "python3 BruteDum.py" ;;
            7) open_wordlists ;;
            0) break ;;
        esac
    done
}

menu_wireless() {
    while true; do
        show_banner
        show_section "Wireless Attack Tools"
        print_menu_item 1 "aircrack-ng"  "WiFi audit suite (Kali)"
        print_menu_item 2 "wifite2"      "Automated WiFi attacks (Kali)"
        print_menu_item 3 "airgeddon"    "Wireless multi-tool (Kali)"
        print_menu_item 4 "bully"        "WPS brute force (Kali)"
        print_menu_item 5 "reaver"       "WPS PIN attack (Kali)"
        print_menu_item 6 "kismet"       "Wireless sniffer (Kali)"
        print_menu_item 7 "bettercap"    "MITM framework (Kali)"
        print_divider
        print_menu_item 0 "Back"         ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1|2|3|4|5|6|7) launch_kali ;;
            0) break ;;
        esac
    done
}

menu_phishing() {
    while true; do
        show_banner
        show_section "Phishing / Social Engineering"
        print_menu_item 1 "zphisher"    "Phishing pages (30+ sites)"
        print_menu_item 2 "nexphisher"  "Advanced phishing tool"
        print_menu_item 3 "SocialFish"  "Social media phishing"
        print_menu_item 4 "seeker"      "Location tracker"
        print_menu_item 5 "camphish"    "Cam phishing"
        print_menu_item 6 "SET (Kali)"  "Social Engineering Toolkit"
        print_menu_item 7 "gophish"     "Phishing framework (Kali)"
        print_divider
        print_menu_item 0 "Back"        ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1) launch_tool "zphisher"   "bash zphisher.sh" ;;
            2) launch_tool "nexphisher" "bash nexphisher.sh" ;;
            3) launch_tool "SocialFish" "python3 SocialFish.py" ;;
            4) launch_tool "seeker"     "bash seeker.sh" ;;
            5) launch_tool "camphish"   "bash camphish.sh" ;;
            6|7) launch_kali ;;
            0) break ;;
        esac
    done
}

menu_forensics() {
    while true; do
        show_banner
        show_section "Forensics & Reverse Engineering"
        print_menu_item 1 "autopsy"     "Digital forensics (Kali)"
        print_menu_item 2 "volatility3" "Memory forensics (Kali)"
        print_menu_item 3 "binwalk"     "Firmware analysis (Kali)"
        print_menu_item 4 "foremost"    "File carving (Kali)"
        print_menu_item 5 "exiftool"    "Metadata viewer (Kali)"
        print_menu_item 6 "ghidra"      "Reverse engineering (Kali)"
        print_menu_item 7 "radare2"     "Disassembler (Kali)"
        print_menu_item 8 "stegtools"   "Steganography (Kali)"
        print_divider
        print_menu_item 0 "Back"        ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1|2|3|4|5|6|7|8) launch_kali ;;
            0) break ;;
        esac
    done
}

menu_network() {
    while true; do
        show_banner
        show_section "Network & MITM Tools"
        print_menu_item 1 "mitmproxy"   "HTTPS interceptor (Kali)"
        print_menu_item 2 "bettercap"   "MITM framework (Kali)"
        print_menu_item 3 "ettercap"    "Network sniffer (Kali)"
        print_menu_item 4 "wireshark"   "Packet analyzer (Kali)"
        print_menu_item 5 "tcpdump"     "CLI sniffer (Kali)"
        print_menu_item 6 "proxychains" "Traffic proxifier (Kali)"
        print_menu_item 7 "tor"         "Anonymizer (Kali)"
        print_menu_item 8 "ncat/socat"  "Netcat alternatives (Kali)"
        print_divider
        print_menu_item 0 "Back"        ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1|2|3|4|5|6|7|8) launch_kali ;;
            0) break ;;
        esac
    done
}

menu_extras() {
    while true; do
        show_banner
        show_section "Extra / All-in-One Frameworks"
        print_menu_item 1 "fsociety"    "All-in-one hacking menu"
        print_menu_item 2 "hackingtool" "350+ tools menu"
        print_menu_item 3 "Cr3dOv3r"   "Credential reuse checker"
        print_menu_item 4 "LaZagne"     "Password recovery"
        print_menu_item 5 "pwncat"      "Post-exploitation shell"
        print_menu_item 6 "httpx"       "HTTP probe toolkit"
        print_menu_item 7 "naabu"       "Port scanner (projectdiscovery)"
        print_divider
        print_menu_item 0 "Back"        ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1) launch_tool "fsociety"    "python3 fsociety.py" ;;
            2) launch_tool "hackingtool" "python3 tools.py" ;;
            3) launch_tool "Cr3dOv3r"   "python3 cr3d0v3r.py" ;;
            4) launch_tool "LaZagne"     "python3 laZagne.py all" ;;
            5) launch_tool "pwncat"      "python3 -m pwncat --help" ;;
            6) launch_tool "httpx"       "./httpx --help 2>/dev/null" ;;
            7) launch_tool "naabu"       "./naabu --help 2>/dev/null" ;;
            0) break ;;
        esac
    done
}

# ── Main menu ───────────────────────────────────────────────────────────────

main_menu() {
    while true; do
        show_banner
        echo -e "  ${BOLD}${WHITE}MAIN MENU${RESET}\n"
        print_menu_item 1 "Information Gathering"   "Recon & OSINT"
        print_menu_item 2 "Web Application"         "Web hacking tools"
        print_menu_item 3 "Exploitation"            "Metasploit & exploits"
        print_menu_item 4 "Password Attacks"        "Hashcat, Hydra, John"
        print_menu_item 5 "Wireless Attacks"        "WiFi, WPS, Bluetooth"
        print_menu_item 6 "Phishing / Social Eng."  "Phishing & SET"
        print_menu_item 7 "Forensics & RevEng"      "Memory, firmware, RE"
        print_menu_item 8 "Network & MITM"          "Sniffing & spoofing"
        print_menu_item 9 "Extra Frameworks"        "All-in-one menus"
        print_divider
        print_menu_item K "Enter Kali Shell"        "Full Kali Linux env"
        print_menu_item W "Wordlists"               "Browse wordlist files"
        print_menu_item U "Update NullY"            "Pull latest updates"
        print_menu_item 0 "Exit"                    ""
        echo ""
        read -p "$(echo -e ${CYAN}Select:${RESET} )" choice
        case $choice in
            1) menu_recon ;;
            2) menu_web ;;
            3) menu_exploit ;;
            4) menu_password ;;
            5) menu_wireless ;;
            6) menu_phishing ;;
            7) menu_forensics ;;
            8) menu_network ;;
            9) menu_extras ;;
            [Kk]) launch_kali ;;
            [Ww]) open_wordlists ;;
            [Uu]) cd "$NULLY_DIR" && git pull --quiet && print_ok "NullY updated." && sleep 1 ;;
            0|[Qq]) echo -e "\n${RED}Goodbye!${RESET}\n"; exit 0 ;;
        esac
    done
}

main_menu
