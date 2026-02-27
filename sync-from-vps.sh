#!/bin/bash
# Glenclaw Sync Script - VPS to Laptop
# Usage: ./sync-from-vps.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Glenclaw Sync - VPS to Laptop${NC}"
echo "================================"

# Push VPS changes first
echo -e "${YELLOW}Pushing VPS changes to GitHub...${NC}"
ssh root@145.223.75.230 "cd /data/notes && git add . && git commit -m 'vps-sync: $(date +%Y-%m-%d\ %H:%M:%S)' || true && git push origin main || true"
echo -e "${GREEN}✓ VPS pushed to GitHub${NC}"

# Pull to laptop
echo -e "${YELLOW}Pulling changes to laptop...${NC}"
git pull origin main
echo -e "${GREEN}✓ Laptop updated${NC}"

echo ""
echo -e "${GREEN}✓ Sync complete!${NC}"
echo "VPS: /data/notes"
echo "Local: ~/Apps/Glenclaw"
