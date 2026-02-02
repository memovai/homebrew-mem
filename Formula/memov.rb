# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/memovai/memov"
  version "0.0.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/memovai/memov/releases/download/v0.0.7/mem-macos-x86_64.tar.gz"
      sha256 "e28ab664c087859e007effa5fb2554ea61040fe67bcf2e6f1f50d55fbbcdfa4d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.7/mem-macos-arm64.tar.gz"
      sha256 "34982e2ae3e706bdf3021d841e100e3d2fc4cefb819b75d13718aa64e3aa9f92"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.7/mem-linux-x86_64.tar.gz"
      sha256 "3295d1899a36f2ad033edbbfbe6acd33e6367071f5ba5ee956e7cb1bdb76f1b0"
    end
  end

  def install
    # onedir format: tarball extracts to mem/ directory, brew cd's into it
    # so we see: mem (binary) + _internal/ (dependencies)
    if File.directory?("_internal") && File.executable?("mem")
      # Install binary and _internal to libexec (keeps them together)
      libexec.install "mem"
      libexec.install "_internal"
      # Create symlink in bin
      bin.install_symlink libexec/"mem"
    elsif File.exist?("mem") && File.executable?("mem")
      # Single binary (onefile mode)
      bin.install "mem"
    else
      # Fallback for legacy named binary format
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
  end

  test do
    system "\#{bin}/mem", "--help"
  end
end
