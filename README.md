# UtilityToolsV2

A high-performance Discord bot for advanced server management and moderation. Automate bulk operations with multi-threaded async execution and rate-limit handling.

## Features

- **Mass Channel Deletion**: Bulk delete all channels in a server with batched async operations
- **Spam Message Broadcasting**: Send messages across multiple channels simultaneously with configurable message content
- **Webhook Spam**: Create webhooks and spam messages through them for distributed posting
- **Mass Ban**: Batch ban users with configurable batch sizes and rate limiting
- **Server Customization**: Automatically rename server and set new identity
- **Fully Configurable**: All parameters (message content, batch sizes, delays) in `config.json`
- **Rate Limit Handling**: Automatic retry logic for Discord API rate limits
- **Virtual Environment Support**: Isolated Python environment for dependencies

## Installation

### Option 1: Automatic Setup (Recommended)

**Windows:**
```bash
build.bat
```

This will:
- Check and install Python 3.13.5 if needed
- Create a virtual environment
- Install all required dependencies (`discord.py`, `aiohttp`)

**macOS/Linux:**
```bash
python3 -m venv venv
source venv/bin/activate
pip install discord.py aiohttp
```

### Option 2: Manual Setup

```bash
pip install discord.py aiohttp
```

## Configuration

All settings are in `config.json`. Edit this file to customize behavior:

```json
{
  "BOT_TOKEN": "your_bot_token_here",
  "MESSAGE_CONTENT": "Message to spam",
  "WEBHOOK_URL": "your_webhook_url",
  "GUILD_NEW_NAME": "New server name",
  "CHANNEL_AMOUNT": 60,
  "BATCH_SIZE_CHANNELS": 60,
  "BATCH_SIZE_DELETE": 30,
  "BATCH_SIZE_BAN": 4,
  "TOTAL_MESSAGES": 800,
  "MAX_MESSAGES_PER_CHANNEL": 18,
  "TOTAL_WEBHOOKS": 2000,
  "WEBHOOK_DELAY": 0.06,
  "SPAM_EMOJIS": ["🏴", "🌙", "🔥", "💀", "👾"],
  "WEBHOOK_USERNAME": "Bot Username",
  "COMMAND_PREFIX": "."
}
```

### Configuration Parameters

| Parameter | Description | Default |
|-----------|-------------|---------|
| `BOT_TOKEN` | Discord bot token | - |
| `MESSAGE_CONTENT` | Content to broadcast | "@everyone \| Message" |
| `WEBHOOK_URL` | Webhook for notifications | - |
| `GUILD_NEW_NAME` | New server name | "Server Nuked" |
| `CHANNEL_AMOUNT` | Total channels to create | 60 |
| `BATCH_SIZE_CHANNELS` | Channels per batch | 60 |
| `BATCH_SIZE_DELETE` | Channels to delete per batch | 30 |
| `BATCH_SIZE_BAN` | Users to ban per batch | 4 |
| `TOTAL_MESSAGES` | Total messages to send | 800 |
| `WEBHOOK_DELAY` | Delay between webhook creates (seconds) | 0.06 |
| `COMMAND_PREFIX` | Command prefix | "." |

## Usage

### Starting the Bot

**Windows:**
```bash
run.bat
```

**macOS/Linux:**
```bash
source venv/bin/activate
python main.py
```

### Commands

All commands require **Administrator** permissions.

#### `.kill`
Creates random channels with emojis and spam content. Sends messages and webhook spam concurrently.
```
.kill
```

**What it does:**
1. Deletes all existing channels
2. Creates 60 new channels with random names and emojis
3. Sends 600 messages across first half of channels
4. Sends 600 webhook messages across second half
5. Renames server
6. Sends invitation link to webhook

#### `.massban`
Mass bans users in the server (excludes bots, caller, and admins).
```
.massban
```

**What it does:**
1. Fetches all members
2. Filters non-bots, non-admins
3. Bans in batches with 1-second delay per batch
4. Reports total banned

#### `.erase`
Deletes all channels in the server.
```
.erase
```

## Getting Your Discord Bot Token

1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Create a new application
3. Go to "Bot" section and click "Add Bot"
4. Copy the token and paste it in `config.json`
5. Enable these intents:
   - Message Content Intent
   - Server Members Intent
6. In OAuth2 > URL Generator, select:
   - Scopes: `bot`
   - Permissions: `Administrator`
7. Use the generated URL to invite bot to your server

## Requirements

- Python 3.13+
- discord.py
- aiohttp
- Windows 10/11 (or Linux/macOS with manual setup)

## Project Structure

```
UtilityToolsV2/
├── main.py              # Main bot code
├── config.json          # Configuration (CUSTOMIZE THIS)
├── build.bat            # Setup script (Windows)
├── run.bat              # Run script (Windows)
└── README.md            # This file
```

## Performance Notes

- Uses async/await for concurrent operations
- Batched requests to respect Discord rate limits
- Automatic retry on rate limit (429) errors
- Configurable delays to fine-tune performance

## Troubleshooting

### Bot won't start
- Ensure `config.json` exists in same directory as `main.py`
- Check bot token is valid
- Run `build.bat` again to ensure dependencies installed

### Commands not working
- Verify you have **Administrator** permissions on the server
- Check bot has `Administrator` role in server
- Ensure bot token has message content intent enabled

### Rate limit errors
- Adjust `BATCH_SIZE_*` values lower
- Increase `WEBHOOK_DELAY`
- Increase delays in sleep() calls in `main.py`

## Disclaimer

This tool is provided for educational and authorized use only. Misuse of this bot to attack or damage Discord servers without authorization is illegal and violates Discord's Terms of Service. Use responsibly.

## License

Open source - use and modify as needed.

## Support

For issues, check:
1. `config.json` is properly formatted JSON
2. Bot token is correct and active
3. Bot has Administrator permissions
4. Server intents are enabled in Developer Portal
