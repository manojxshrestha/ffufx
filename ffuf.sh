#!/bin/bash

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Banner
echo -e "${RED}"
echo "              ___  ___       ___     "
echo "             |__  |__  |  | |__  \_/ "
echo "             |    |    \__/ |    / \ "
echo -e "${NC}"
echo -e "${GREEN}                       ~by manojxshrestha${NC}"
echo -e "${YELLOW}________________________________________________${NC}"
echo -e "${NC}Select a wordlist folder and file to start fuzzing!${NC}"
echo -e "${YELLOW}Enter Target Domain (e.g., https://example.com)${NC}"

# Main function
main() {
    # Prompt for target domain
    read -p "$(echo -e "${RED}👉 Target: ${NC}")" TARGET
    if [[ -z "$TARGET" ]]; then
        echo -e "${RED}[ERROR] No target specified.${NC}"
        exit 1
    fi

    # Ensure target starts with http:// or https://
    if [[ ! "$TARGET" =~ ^http(s)?:// ]]; then
        echo -e "${RED}[ERROR] Target must start with http:// or https://${NC}"
        exit 1
    fi

    # Ensure trailing slash
    [[ "$TARGET" =~ /$ ]] || TARGET="${TARGET}/"

    # Wordlist categories
    echo -e "${GREEN}Available Wordlist Folders and Purposes:${NC}"
    echo -e "${YELLOW}________________________________________________${NC}"
    echo -e "${RED}1) DirectoryAndFileDiscovery${NC} - Discover dirs/files"
    echo -e "${RED}2) FileExtensionsAndTypes${NC} - Find files by extension"
    echo -e "${RED}3) ParameterAndInputFuzzing${NC} - Fuzz parameters"
    echo -e "${RED}4) BackupAndSensitiveData${NC} - Find backups/logs"
    echo -e "${RED}5) ServerSpecificResources${NC} - Apache, CGI, etc."
    echo -e "${RED}6) QuickAndHighProbabilityHits${NC} - Quick hits"
    echo -e "${RED}7) RobotsTxtDisallowedPaths${NC} - robots.txt paths"
    echo -e "${RED}8) SubdomainEnumeration${NC} - Fuzz subdomains"
    echo -e "${RED}9) CustomAndSpecialized${NC} - Niche/custom lists"
    echo -e "${YELLOW}________________________________________________${NC}"

    # Folder selection
    PS3="Select folder number: "
    folders=("DirectoryAndFileDiscovery" "FileExtensionsAndTypes" "ParameterAndInputFuzzing" "BackupAndSensitiveData" "ServerSpecificResources" "QuickAndHighProbabilityHits" "RobotsTxtDisallowedPaths" "SubdomainEnumeration" "CustomAndSpecialized" "Quit")
    select folder in "${folders[@]}"; do
        case "${folder,,}" in
            "quit")
                echo -e "${YELLOW}[+] Exiting...${NC}"
                exit 0
                ;;
            *)
                if [[ -d "$PWD/$folder" ]]; then
                    echo -e "${GREEN}Wordlists in $folder:${NC}"
                    mapfile -t wordlists < <(ls "$PWD/$folder"/*.txt 2>/dev/null)
                    if [[ ${#wordlists[@]} -eq 0 ]]; then
                        echo -e "${RED}[ERROR] No wordlists found in $folder.${NC}"
                        exit 1
                    fi
                    for i in "${!wordlists[@]}"; do
                        echo -e "${RED}$((i+1))) ${wordlists[$i]##*/}${NC}"
                    done

                    PS3="Select wordlist number: "
                    select wordlist in "${wordlists[@]}" "Back"; do
                        case "${wordlist,,}" in
                            "back")
                                break
                                ;;
                            *)
                                if [[ -n "$wordlist" ]]; then
                                    WORDLIST="$wordlist"
                                    break 2
                                else
                                    echo -e "${RED}[ERROR] Invalid selection. Try again.${NC}"
                                fi
                                ;;
                        esac
                    done
                else
                    echo -e "${RED}[ERROR] Folder $folder not found.${NC}"
                    exit 1
                fi
                ;;
        esac
    done

    # Validate wordlist
    if [[ ! -f "$WORDLIST" ]]; then
        echo -e "${RED}[ERROR] Wordlist $WORDLIST not found.${NC}"
        exit 1
    fi

    # Run ffuf
    echo -e "${GREEN}[+] Running ffuf with wordlist: ${RED}${WORDLIST##*/}${NC}"
    echo "================================================"
    echo -e "${YELLOW}Scanning... (This may take a while)${NC}"

    if ffuf \
        -w "$WORDLIST" \
        -u "${TARGET}FUZZ" \
        -fc 403,400,401,402,404,429,500,501,502,503 \
        -recursion \
        -recursion-depth 2 \
        -c \
        -v \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) Gecko/20100101 Firefox/91.0" \
        -H "X-Forwarded-For: 127.0.0.1" \
        -H "X-Originating-IP: 127.0.0.1" \
        -H "X-Forwarded-Host: localhost" \
        -t 100 \
        -mc 200,204,301,302,307 \
        -o ffufresults.html -of html; then

        echo -e "${GREEN}[+] Scan complete. Results saved to ${YELLOW}ffufresults.html${NC}"
        echo "===================================================="
    else
        echo -e "${RED}[ERROR] FFUF execution failed. Check logs or network.${NC}"
    fi
}

# Check if ffuf is installed
if ! command -v ffuf &> /dev/null; then
    echo -e "${RED}[ERROR] ffuf is not installed. Please install ffuf first.${NC}"
    exit 1
fi

# Run the script
main
