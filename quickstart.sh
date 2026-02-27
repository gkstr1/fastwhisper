#!/bin/bash
# Glenclaw Quickstart - Setup script
# Usage: ./quickstart.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════╗"
echo "║       Glenclaw Notes System          ║"
echo "║      Quickstart & Sync Tool          ║"
echo "╚══════════════════════════════════════╝"
echo -e "${NC}"

show_menu() {
    echo ""
    echo -e "${YELLOW}Choose an action:${NC}"
    echo "1) Sync Laptop → VPS (push changes)"
    echo "2) Sync VPS → Laptop (pull changes)"
    echo "3) Check status"
    echo "4) View folder structure"
    echo "5) Exit"
    echo ""
}

sync_to_vps() {
    echo -e "${YELLOW}Syncing Laptop → VPS...${NC}"
    ./sync-to-vps.sh
}

sync_from_vps() {
    echo -e "${YELLOW}Syncing VPS → Laptop...${NC}"
    ./sync-from-vps.sh
}

check_status() {
    echo -e "${YELLOW}Repository Status${NC}"
    echo "================="
    git status
    echo ""
    echo -e "${YELLOW}Last 5 commits:${NC}"
    git log --oneline -5
}

show_structure() {
    echo -e "${YELLOW}Glenclaw Structure${NC}"
    echo "=================="
    tree -L 2 || find . -maxdepth 2 -type d | head -20
    echo ""
    echo -e "${GREEN}Locations:${NC}"
    echo "• Laptop: ~/Apps/Glenclaw"
    echo "• VPS: /data/notes"
}

# Main loop
while true; do
    show_menu
    read -p "Enter choice (1-5): " choice
    
    case $choice in
        1) sync_to_vps ;;
        2) sync_from_vps ;;
        3) check_status ;;
        4) show_structure ;;
        5) echo -e "${GREEN}Goodbye!${NC}"; exit 0 ;;
        *) echo -e "${YELLOW}Invalid choice. Try again.${NC}" ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
done
