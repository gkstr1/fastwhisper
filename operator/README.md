# Operator

System operations, infrastructure management, and DevOps documentation.

## Server Infrastructure

### VPS (Hostinger) - OpenClaw
- **IP:** 145.223.75.230
- **User:** root
- **Docker:** OpenClaw container running
- **Notes Path:** /data/notes

### Commands Reference
```bash
# SSH into VPS
ssh root@145.223.75.230

# Docker management
docker ps
docker logs <container>
docker exec -it <container> /bin/bash

# System updates
apt update && apt upgrade -y
```

## Git Repositories

### Glenclaw Sync
- **Local:** ~/Apps/Glenclaw
- **Remote:** https://github.com/gkstr1/Glenclaw.git
- **VPS:** /data/notes

### Scorecard ATS
- **Location:** ~/Desktop/Apps
- **Stack:** React + TypeScript + Vite + Supabase

## Backup Procedures

### Daily Tasks
- [ ] Sync Glenclaw notes
- [ ] Check VPS disk space
- [ ] Review error logs

### Weekly Tasks
- [ ] Update packages
- [ ] Clean up old logs
- [ ] Backup critical data

## Quick Commands

```bash
# Sync laptop to VPS
cd ~/Apps/Glenclaw && git push
ssh root@145.223.75.230 "cd /data/notes && git pull"

# Sync VPS to laptop  
ssh root@145.223.75.230 "cd /data/notes && git push"
cd ~/Apps/Glenclaw && git pull
```
