# Glenclaw Notes Repository

A centralized notes system for Windsurf (laptop) and OpenClaw (VPS) synchronization.

## Structure

- `inbox/` - Quick captures and unprocessed notes
- `operator/` - System operations and management
- `recruiting/` - Recruitment and ATS related notes
- `trading/` - Trading strategies and analysis
- `openclaw-system/` - OpenClaw system documentation
- `personal/` - Personal notes and references

## Repository Locations

- **Laptop (Windsurf)**: `~/Apps/Glenclaw`
- **VPS (OpenClaw)**: `/data/notes`

## Quick Sync Commands

### Laptop → VPS (Push changes)
```bash
cd ~/Apps/Glenclaw
./sync-to-vps.sh "your commit message"
```

### VPS → Laptop (Pull changes)
```bash
cd ~/Apps/Glenclaw
./sync-from-vps.sh
```

## Manual Sync Workflow

### Laptop → VPS
```bash
cd ~/Apps/Glenclaw
git add .
git commit -m "update notes"
git push
```

Then on VPS:
```bash
cd /data/notes
git pull
```

### VPS → Laptop
On VPS:
```bash
cd /data/notes
git add .
git commit -m "server updates"
git push
```

Then on laptop:
```bash
cd ~/Apps/Glenclaw
git pull
```
