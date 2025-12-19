# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/IRONICBo/mem-mcp-server"
  version "0.0.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.10/mem-macos-x86_64.tar.gz"
      sha256 "c28b49787448b6c0bd94432cdf1b3e6206307c859e96960de5170399c1889139"
    end
    if Hardware::CPU.arm?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.10/mem-macos-arm64.tar.gz"
      sha256 "8df562fa5e9bab7d30e7aab19e8df0264c6a2c84a4831d72c253951999987e61"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.10/mem-linux-x86_64.tar.gz"
      sha256 "fa9fb614db83718fc2f2990fe10061bb595b8ebc25859fb013da188ae52c31be"
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
