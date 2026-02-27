# OpenClaw System

Documentation and configuration for the OpenClaw AI system running on VPS.

## System Architecture

### Hostinger VPS
- **IP:** 145.223.75.230
- **User:** root
- **Docker:** OpenClaw container
- **Notes Path:** /data/notes

### OpenClaw Container
**Location:** /data/notes (Glenclaw repo)
**Function:** AI agent system
**Access:** SSH + Docker exec

## Configuration

### Environment Variables
```bash
# API Keys
OPENAI_API_KEY=
ANTHROPIC_API_KEY=
DEEPSEEK_API_KEY=

# Database
SUPABASE_URL=
SUPABASE_KEY=

# Integrations
TWILIO_SID=
TWILIO_TOKEN=
ZOOM_API_KEY=
LINKEDIN_CLIENT_ID=
```

### Notes Integration
OpenClaw reads from and writes to:
- `/data/notes/inbox/` - Quick captures
- `/data/notes/operator/` - System commands
- `/data/notes/recruiting/` - ATS operations
- `/data/notes/trading/` - Market analysis

## Workflows

### Daily Sync Process
```bash
# Pull latest from GitHub
cd /data/notes && git pull origin main

# Process any new items
# [OpenClaw logic here]

# Push changes back
cd /data/notes && git add . && git commit -m "OpenClaw updates" && git push
```

### Recruiting Automation
1. Check `recruiting/inbox/` for new candidates
2. Parse LinkedIn profiles
3. Update ATS pipeline
4. Generate interview questions
5. Create scorecards

### Trading Analysis
1. Read `trading/watchlist/` for setups
2. Analyze market data
3. Write analysis to `trading/analysis/`
4. Update journal entries

## Commands Reference

```bash
# SSH into VPS
ssh root@145.223.75.230

# Access OpenClaw container
docker exec -it openclaw /bin/bash

# View logs
docker logs openclaw --tail 100

# Restart container
docker restart openclaw

# Sync notes manually
cd /data/notes && git pull && git push
```

## Development

### Adding New Capabilities
1. Document in this folder
2. Update automation scripts
3. Test on VPS
4. Sync to laptop

### Debugging
- Check logs: `docker logs openclaw`
- Test commands manually
- Verify file permissions in /data/notes
