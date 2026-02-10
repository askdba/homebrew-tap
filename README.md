# Homebrew Tap for askdba

Homebrew formulae for askdba projects.

## Installation

```bash
brew install askdba/tap/mysql-mcp-server
```

**Update local installation** (after a new release):

```bash
brew update && brew upgrade mysql-mcp-server
```

## Formulae

### mysql-mcp-server

MySQL MCP Server - A fast, read-only MySQL server for the Model Context Protocol (MCP).

**Features:**
- Claude Desktop integration via MCP
- REST API mode for ChatGPT/Gemini (port 9306)
- Multi-DSN support (connect to multiple databases)
- MariaDB support (10.x, 11.x)
- Vector search (MySQL 9.0+)
- Read-only, safe SQL execution
- Supports MySQL 8.0, 8.4, 9.0 and MariaDB 10.x, 11.x

**Quick Start:**

```bash
# Install
brew install askdba/tap/mysql-mcp-server

# Configure Claude Desktop
# Edit: ~/Library/Application Support/Claude/claude_desktop_config.json
# (macOS) or ~/.config/Claude/claude_desktop_config.json (Linux)
{
  "mcpServers": {
    "mysql": {
      "command": "mysql-mcp-server",
      "env": {
        "MYSQL_DSN": "user:password@tcp(localhost:3306)/database"
      }
    }
  }
}
```

**REST API Mode (for ChatGPT/Gemini):**

```bash
MYSQL_DSN="user:password@tcp(localhost:3306)/mydb" \
MYSQL_MCP_HTTP=1 \
mysql-mcp-server

# Then: curl http://localhost:9306/api/databases
```

**Documentation:** [github.com/askdba/mysql-mcp-server](https://github.com/askdba/mysql-mcp-server)

## License

Apache License 2.0
