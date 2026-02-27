#!/bin/bash
# Glenclaw Sync Script - Laptop to VPS
# Usage: ./sync-to-vps.sh ["commit message"]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Glenclaw Sync - Laptop to VPS${NC}"
echo "================================"

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
    echo -e "${YELLOW}Found uncommitted changes...${NC}"
    
    # Add all changes
    git add .
    
    # Commit with provided message or default
    if [ -z "$1" ]; then
        COMMIT_MSG="auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    else
        COMMIT_MSG="$1"
    fi
    
    git commit -m "$COMMIT_MSG"
    echo -e "${GREEN}✓ Committed changes${NC}"
else
    echo -e "${GREEN}✓ No uncommitted changes${NC}"
fi

# Push to GitHub
echo -e "${YELLOW}Pushing to GitHub...${NC}"
git push origin main
echo -e "${GREEN}✓ Pushed to GitHub${NC}"

# Pull on VPS
echo -e "${YELLOW}Pulling changes on VPS...${NC}"
ssh root@145.223.75.230 "cd /data/notes && git pull origin main"
echo -e "${GREEN}✓ VPS updated${NC}"

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
echo "Local: ~/Apps/Glenclaw"
echo "VPS: /data/notes"
