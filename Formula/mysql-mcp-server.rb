class MysqlMcpServer < Formula
  desc "MySQL MCP Server - Model Context Protocol server for MySQL databases"
  homepage "https://github.com/askdba/mysql-mcp-server"
  version "1.2.0"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.0/mysql-mcp-server_1.2.0_darwin_amd64.tar.gz"
      sha256 "9badf03bd7a97e5ff64366ec914470ffd50cc3b1dfb54d13592a48ae3186b303"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.0/mysql-mcp-server_1.2.0_darwin_arm64.tar.gz"
      sha256 "d2df2d809aa35157d8b0562ec7d68b48e2b1c95b3d988348003785aed428b9f7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.0/mysql-mcp-server_1.2.0_linux_amd64.tar.gz"
      sha256 "b4471fa73ee92511aa5028081e9d7d2a3870bb6fdd3c35d25c97de74f79db152"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.0/mysql-mcp-server_1.2.0_linux_arm64.tar.gz"
      sha256 "6775b1e6d466eac81118f3623d0432af975c1b9d74763cead68257f1d9cf14d7"
    end
  end

  def install
    bin.install "mysql-mcp-server"
  end

  def caveats
    <<~EOS
      To use mysql-mcp-server with Claude Desktop, add to your config:

        {
          "mcpServers": {
            "mysql": {
              "command": "#{opt_bin}/mysql-mcp-server",
              "env": {
                "MYSQL_DSN": "user:password@tcp(localhost:3306)/database"
              }
            }
          }
        }

      Config location:
        macOS: ~/Library/Application Support/Claude/claude_desktop_config.json
        Linux: ~/.config/Claude/claude_desktop_config.json
    EOS
  end

  test do
    # Basic test - server should fail without MYSQL_DSN but show proper error
    output = shell_output("#{bin}/mysql-mcp-server 2>&1", 1)
    assert_match(/MYSQL_DSN|config error/i, output)
  end
end

