# NullY — All-in-One Kali Linux Tools for Termux

One-click installer and launcher for **every Kali Linux tool** inside Termux.

## One-Click Install

```bash
pkg install git -y && git clone https://github.com/fizanali/null NullY && cd NullY && bash install.sh
```

## What Gets Installed

| Category | Tools |
|---|---|
| Information Gathering | nmap, masscan, theHarvester, subfinder, amass, recon-ng, nikto, wpscan, dnsx, nuclei, + more |
| Web Application | sqlmap, XSStrike, Arjun, gobuster, ffuf, burpsuite, zaproxy, wfuzz, feroxbuster |
| Exploitation | Metasploit, searchsploit, BeEF, Responder, Evil-WinRM, CrackMapExec |
| Password Attacks | hashcat, john, hydra, medusa, crunch, BruteDum |
| Wireless | aircrack-ng, wifite2, airgeddon, reaver, bully, kismet, bettercap |
| Phishing / SE | zphisher, nexphisher, SocialFish, seeker, camphish, SET |
| Forensics | autopsy, volatility3, binwalk, foremost, exiftool, sleuthkit |
| Reverse Engineering | ghidra, radare2, cutter, gdb, apktool, dex2jar, jadx |
| Network / MITM | mitmproxy, bettercap, ettercap, wireshark, proxychains, tor |
| Extra Frameworks | fsociety, hackingtool, LaZagne, Cr3dOv3r, pwncat |
| Wordlists | rockyou, SecLists (subdomains, dirs, XSS, SQLi, LFI, ...) |

## Requirements

- Android 7+ with [Termux](https://f-droid.org/packages/com.termux/) (F-Droid version recommended)
- ~10 GB free storage
- WiFi connection recommended
- Root **not required** (uses proot)

## Usage

```bash
nully       # Open main menu
kali        # Jump directly into Kali Linux shell
```

## Structure

```
NullY/
├── install.sh          ← One-click installer (run this)
├── nully.sh            ← Interactive menu launcher
├── utils/
│   ├── colors.sh       ← Terminal colors
│   ├── banner.sh       ← ASCII banner & print helpers
│   └── helpers.sh      ← Shared utility functions
└── tools/
    ├── native.sh       ← Termux-native packages & pip tools
    ├── kali_base.sh    ← Kali Linux proot setup
    ├── kali_tools.sh   ← All Kali tool categories
    ├── extra_tools.sh  ← GitHub-sourced extra tools
    └── wordlists.sh    ← Wordlist downloader
```

## Disclaimer

For authorized penetration testing, CTF competitions, and educational use only.
