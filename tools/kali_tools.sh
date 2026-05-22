#!/bin/bash
# Install Kali tool metapackages and individual tools inside proot

install_kali_tools() {

    # ── Information Gathering ───────────────────────────────────────────────
    show_section "Information Gathering Tools"
    local recon_tools=(
        nmap masscan unicornscan dmitry dnsenum dnsrecon fierce
        maltego recon-ng theharvester osrframework
        whois netdiscover arp-scan nbtscan enum4linux
        smbclient smbmap ldap-utils snmpcheck onesixtyone
        nikto whatweb wafw00f wpscan joomscan
        amass subfinder assetfinder httprobe
    )
    for t in "${recon_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Vulnerability Analysis ──────────────────────────────────────────────
    show_section "Vulnerability Analysis Tools"
    local vuln_tools=(
        openvas nessus-agent lynis
        sqlmap oscanner tnscmd10g sidguesser
        unix-privesc-check linux-exploit-suggester
        vulnix
    )
    for t in "${vuln_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Web Application ─────────────────────────────────────────────────────
    show_section "Web Application Tools"
    local web_tools=(
        burpsuite zaproxy dirb dirbuster gobuster feroxbuster
        ffuf wfuzz hydra medusa
        sqlmap xsser commix
        cutycapt eyewitness
        httptunnel proxychains-ng tor
    )
    for t in "${web_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Password Attacks ────────────────────────────────────────────────────
    show_section "Password Attack Tools"
    local pass_tools=(
        hashcat john hydra medusa
        crunch wordlists rockyou
        hash-identifier findmyhash
        ophcrack chntpw samdump2
        fcrackzip pdfcrack rarcrack
    )
    for t in "${pass_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Wireless Attacks ────────────────────────────────────────────────────
    show_section "Wireless Attack Tools"
    local wifi_tools=(
        aircrack-ng airgeddon wifite2
        bully reaver pixiewps
        mdk4 hostapd-wpe
        kismet wireshark tshark tcpdump
        bluetoothctl bluez ubertooth
    )
    for t in "${wifi_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Exploitation Tools ──────────────────────────────────────────────────
    show_section "Exploitation Tools"
    local exploit_tools=(
        metasploit-framework
        exploitdb searchsploit
        beef-xss
        responder
        crackmapexec evil-winrm
        impacket-scripts
        set
    )
    for t in "${exploit_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Sniffing & Spoofing ─────────────────────────────────────────────────
    show_section "Sniffing & Spoofing Tools"
    local sniff_tools=(
        wireshark tshark tcpdump ettercap-graphical dsniff
        arpwatch netsniff-ng
        mitmproxy bettercap
        ssldump sslstrip
        yersinia macchanger
    )
    for t in "${sniff_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Post Exploitation ───────────────────────────────────────────────────
    show_section "Post Exploitation Tools"
    local post_tools=(
        empire covenant
        powersploit
        mimikatz
        ncat socat
        weevely
        laudanum
        dbd
    )
    for t in "${post_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Forensics ───────────────────────────────────────────────────────────
    show_section "Forensics Tools"
    local forensic_tools=(
        autopsy sleuthkit volatility3
        foremost scalpel bulk-extractor
        binwalk dd_rescue dcfldd ddrescue
        exiftool pdfinfo
        regripper
        xmount afflib-tools
        guymager
    )
    for t in "${forensic_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Reverse Engineering ─────────────────────────────────────────────────
    show_section "Reverse Engineering Tools"
    local re_tools=(
        ghidra radare2 cutter
        gdb pwndbg peda
        apktool dex2jar jadx
        strace ltrace
        objdump strings hexdump
    )
    for t in "${re_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Social Engineering ──────────────────────────────────────────────────
    show_section "Social Engineering Tools"
    local se_tools=(
        set
        gophish
        maltego
    )
    for t in "${se_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Crypto & Stego ──────────────────────────────────────────────────────
    show_section "Crypto & Steganography Tools"
    local crypto_tools=(
        steghide stegcracker outguess
        stegosuite steganabara
        openssl gnupg2
        hashdeep
        cryptsetup
    )
    for t in "${crypto_tools[@]}"; do kali_pkg_install "$t"; done

    # ── Reporting ───────────────────────────────────────────────────────────
    show_section "Reporting Tools"
    local report_tools=(
        dradis pipal cherrytree recordmydesktop
        cutycapt faraday-client
    )
    for t in "${report_tools[@]}"; do kali_pkg_install "$t"; done

    print_ok "All Kali tool categories installed."
}
