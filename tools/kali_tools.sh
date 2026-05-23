#!/bin/bash
# Install Kali tools inside proot — one apt-get per category (fast + reliable)

# Run one apt-get install for an entire category
kali_install_group() {
    local label="$1"
    shift
    local pkgs=("$@")
    print_arrow "Installing: $label"
    proot-distro login kali -- bash -c "
        DEBIAN_FRONTEND=noninteractive apt-get install -y --fix-missing --no-install-recommends ${pkgs[*]} 2>&1 | grep -E '(Setting up|unable to locate|E:)' | head -20
    " || true
    print_ok "Done: $label"
}

install_kali_tools() {

    # Refresh package lists once before everything
    show_section "Refreshing Kali Package Lists"
    proot-distro login kali -- bash -c "apt-get update -y" 2>&1 | tail -3
    print_ok "Package lists updated."

    # ── Information Gathering ───────────────────────────────────────────────
    show_section "Information Gathering Tools"
    kali_install_group "Recon / Network" \
        nmap masscan unicornscan dmitry dnsenum dnsrecon fierce \
        whois netdiscover arp-scan nbtscan enum4linux \
        smbclient smbmap ldap-utils snmp onesixtyone \
        nikto whatweb wafw00f wpscan \
        recon-ng theharvester

    kali_install_group "Subdomain / Web Discovery" \
        amass gobuster feroxbuster ffuf wfuzz \
        dirb dirbuster

    # ── Vulnerability Analysis ──────────────────────────────────────────────
    show_section "Vulnerability Analysis Tools"
    kali_install_group "Vuln Scanners" \
        lynis sqlmap oscanner \
        unix-privesc-check

    # ── Web Application ─────────────────────────────────────────────────────
    show_section "Web Application Tools"
    kali_install_group "Web Hacking" \
        burpsuite zaproxy sqlmap xsser commix \
        curl wget httpie

    kali_install_group "Proxies / Tunnels" \
        proxychains4 tor httptunnel socat

    # ── Password Attacks ────────────────────────────────────────────────────
    show_section "Password Attack Tools"
    kali_install_group "Password Cracking" \
        hashcat john hydra medusa \
        crunch wordlists \
        hash-identifier \
        fcrackzip pdfcrack

    # ── Wireless Attacks ────────────────────────────────────────────────────
    show_section "Wireless Attack Tools"
    kali_install_group "WiFi Tools" \
        aircrack-ng mdk4 \
        bully reaver pixiewps \
        kismet tshark tcpdump

    # ── Exploitation Tools ──────────────────────────────────────────────────
    show_section "Exploitation Tools"
    kali_install_group "Metasploit & Exploits" \
        metasploit-framework \
        exploitdb \
        beef-xss \
        responder \
        set

    kali_install_group "Windows Attacks" \
        crackmapexec evil-winrm \
        impacket-scripts

    # ── Sniffing & Spoofing ─────────────────────────────────────────────────
    show_section "Sniffing & Spoofing Tools"
    kali_install_group "MITM / Sniffing" \
        wireshark-common tshark tcpdump \
        dsniff arpwatch \
        mitmproxy bettercap \
        sslstrip yersinia macchanger \
        netsniff-ng

    # ── Post Exploitation ───────────────────────────────────────────────────
    show_section "Post Exploitation Tools"
    kali_install_group "Post-Exploit" \
        weevely \
        ncat socat \
        powersploit \
        dbd

    # ── Forensics ───────────────────────────────────────────────────────────
    show_section "Forensics Tools"
    kali_install_group "File Forensics" \
        autopsy sleuthkit \
        foremost scalpel bulk-extractor \
        binwalk \
        dc3dd dcfldd ddrescue \
        exiftool xmount afflib-tools

    kali_install_group "Memory Forensics" \
        volatility3

    # ── Reverse Engineering ─────────────────────────────────────────────────
    show_section "Reverse Engineering Tools"
    kali_install_group "RE Tools" \
        radare2 \
        gdb \
        apktool dex2jar jadx \
        strace ltrace \
        binutils

    # ── Crypto & Stego ──────────────────────────────────────────────────────
    show_section "Crypto & Steganography Tools"
    kali_install_group "Stego / Crypto" \
        steghide stegcracker outguess \
        openssl gnupg2 \
        hashdeep

    # ── Social Engineering ──────────────────────────────────────────────────
    show_section "Social Engineering Tools"
    kali_install_group "Social Engineering" \
        set gophish

    # ── Reporting ───────────────────────────────────────────────────────────
    show_section "Reporting Tools"
    kali_install_group "Reporting" \
        pipal cherrytree faraday-client

    print_ok "All Kali tool categories installed."
}
