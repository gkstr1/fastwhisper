# Multichannel outreach + sales stack (IMPORTANT)

## Goal
Enable compliant multi-channel outreach (cold email + SMS + calls/voicemail drops + LinkedIn-style prospecting) with tracking, templates, approvals, and guardrails.

## Non-negotiables (compliance / deliverability)
- **Consent & laws**: comply with CAN-SPAM (US), TCPA (US), GDPR/UK PECR (EU/UK), and local rules.
- **Opt-out**: email + SMS must include opt-out handling.
- **Rate limits**: ramp domains/inboxes slowly; avoid blasts.
- **Audit trail**: log what was sent, to whom, and why.
- **No ToS evasion**: avoid “scraping hacks” that violate platform terms.

## Systems to connect (recommended)

### 1) Lead source / data layer (where prospects live)
Pick ONE system of record:
- **Airtable** (fast to build, flexible)
- **HubSpot** (real CRM + sequences)
- **Clay** (enrichment + workflow, popular for outbound)

Minimum fields:
- Company, name, title, email(s), phone, LinkedIn URL, location
- Source + date collected
- ICP segment + score
- Compliance flags (consent/legitimate interest, do-not-contact)

### 2) Cold email sending (deliverability-first)
Options:
- **Google Workspace / Microsoft 365 inboxes** with a sequencer: Instantly, Smartlead, Apollo, HubSpot Sequences
- Or **transactional providers** (SendGrid/Mailgun) *only* for opt-in/transactional; not for cold outreach.

Needed capabilities:
- Multi-inbox sending
- Bounce handling + suppression lists
- Unsubscribe links + auto-processing
- Warmup/ramp controls

### 3) SMS
Options:
- **Twilio** (flexible API)
- **Telnyx** (often cheaper)

Needed:
- A2P 10DLC registration (US)
- STOP/HELP compliance + opt-out management

### 4) Voice / calling / voicemail drops
Options:
- **Twilio Voice** (calls + recordings + programmable voicemail)
- Specialized platforms for drops (varies); ensure **legal compliance** in your target geography.

Needed:
- Call tracking per prospect
- Recording/voicemail templates
- Local presence (optional)

### 5) LinkedIn prospecting (COMPLIANT)
Avoid direct scraping/botting.
Do instead:
- Use **Sales Navigator** manually for search + list building.
- Export prospects via compliant workflows:
  - Save leads to lists, then **manual export** into your CRM (or a tool that is explicitly allowed by your org/legal).
- Use **enrichment** to find verified emails/phones from company domains.

### 6) Enrichment / verification
- **Dropcontact / Clearbit / Apollo / People Data Labs** (depends on budget + geography)
- **NeverBounce / ZeroBounce** (email verification)

### 7) Sequencing / orchestration (the “brain”)
- Outbound sequencer (Instantly/Smartlead/HubSpot)
- Or automation layer: **Zapier / Make / n8n**

What to automate:
- New lead → enrich → score → assign sequence
- Reply received → stop sequences + notify
- “Book meeting” intent → create calendar hold + Slack/Telegram ping

### 8) Analytics
- Track: sent/open/reply/booked, by segment + channel
- Keep a weekly dashboard in operator notes

## OpenClaw’s role
- Draft copy per segment (email/SMS/voicemail) **for approval**
- Maintain sequences + templates in Markdown
- Pull lead lists from CRM, propose next actions
- Generate daily outbound “queue” and reminders
- Log actions + decisions in notes repo

## Next actions (tomorrow)
1) Choose system of record: Airtable vs HubSpot vs Clay
2) Choose email sequencer: Instantly vs Smartlead vs HubSpot
3) Choose SMS/Voice: Twilio vs Telnyx
4) Define ICP segments + messaging pillars (1 page)
5) Define compliance rules + do-not-contact policy
