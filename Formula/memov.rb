# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/memovai/memov"
  version "0.0.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/memovai/memov/releases/download/v0.0.2/mem-macos-x86_64.tar.gz"
      sha256 "7a6e89f3209f1896c821b501d69ce98d76151eef4875f761c8c5b5213b0655b3"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.2/mem-macos-arm64.tar.gz"
      sha256 "ddb674d28d7ab2b7406ec0c0d2ee6b178bd8d2ba003ef4c6812d8fdb692481b2"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.2/mem-linux-x86_64.tar.gz"
      sha256 "42e1a3e1ef89091a5a5b82b61e339a90d92a783e05d730d745845ec144d66b1d"
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
