# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/IRONICBo/mem-mcp-server"
  version "0.0.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.9/mem-macos-x86_64.tar.gz"
      sha256 "9cad83a47af62b85321f6c3e35360f9cc2a1a1e10f8184377e4c27acb485fab7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.9/mem-macos-arm64.tar.gz"
      sha256 "e3ffdc67ea75b5fd0ac3de678d1e17aae119797ba3944c22249d20c53c73a180"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.9/mem-linux-x86_64.tar.gz"
      sha256 "84643c6581a0bc07edb77d14b39454fbb1d766275c714433b7f83001f7bce986"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.intel?
        bin.install "mem-macos-x86_64" => "mem"
      else
        bin.install "mem-macos-arm64" => "mem"
      end
    else
      bin.install "mem-linux-x86_64" => "mem"
    end
  end

  test do
    system "\#{bin}/mem", "--help"
  end
end
