# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/memovai/memov"
  version "0.0.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/memovai/memov/releases/download/v0.0.8/mem-macos-x86_64.tar.gz"
      sha256 "b1920de21f955b6b5f52df64d31df727d00ebb1dc3bd4badf75c1e646fb3e332"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.8/mem-macos-arm64.tar.gz"
      sha256 "5d4ac3ab36372cf40d9419ad143296b00b82f03207042482fb2c838131e304d8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.8/mem-linux-x86_64.tar.gz"
      sha256 "0f4e908a175ea6f9fc86eb0ab8a3841bef2ceb774fe5b03104c4c5cc9b074eec"
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
