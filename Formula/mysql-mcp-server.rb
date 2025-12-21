class MysqlMcpServer < Formula
  desc "MySQL MCP Server - Model Context Protocol server for MySQL databases"
  homepage "https://github.com/askdba/mysql-mcp-server"
  version "1.3.1"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.3.1/mysql-mcp-server_1.3.1_darwin_amd64.tar.gz"
      sha256 "63eafd06d802cf68e7f3a9f13f8dea83c9ae9bb156d43bd1eafae055c45cba85"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.3.1/mysql-mcp-server_1.3.1_darwin_arm64.tar.gz"
      sha256 "903a25134c99c29328b60f472ef8b71aa405040d8d1541b319b6841a0430b61a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.3.1/mysql-mcp-server_1.3.1_linux_amd64.tar.gz"
      sha256 "0f5c9b2db7c8a4d7eca1476398cb358e59230e1b2237a63159f377bcef20d260"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.3.1/mysql-mcp-server_1.3.1_linux_arm64.tar.gz"
      sha256 "97399d5a3989591aca4622ec06342d6f2fb14f09047394e1ce41532ffd8366b1"
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
