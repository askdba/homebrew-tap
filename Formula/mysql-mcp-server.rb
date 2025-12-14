class MysqlMcpServer < Formula
  desc "MySQL MCP Server - Model Context Protocol server for MySQL databases"
  homepage "https://github.com/askdba/mysql-mcp-server"
  version "1.2.1"
  license "Apache-2.0"

  on_macos do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.1/mysql-mcp-server_1.2.1_darwin_amd64.tar.gz"
      sha256 "0123559cdd7fa8467f5bdf3655ef0cc3cc6a5304230828f7ee8111026083c80a"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.1/mysql-mcp-server_1.2.1_darwin_arm64.tar.gz"
      sha256 "3bff58f244bfe1e3d1cd2c663762812ec318aeafe89fd0a9ff67dcd5b752ac80"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.1/mysql-mcp-server_1.2.1_linux_amd64.tar.gz"
      sha256 "b9f46301eb85ee6a726f9589e830f84c7a1094acdfd0c5011bb3aae5729ee084"
    end
    on_arm do
      url "https://github.com/askdba/mysql-mcp-server/releases/download/v1.2.1/mysql-mcp-server_1.2.1_linux_arm64.tar.gz"
      sha256 "f97a16e1a105146d08dfeaae807d9ab7462c57d2befdd7fb5c83a273901b195e"
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
