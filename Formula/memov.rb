# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/memovai/memov"
  version "0.0.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/memovai/memov/releases/download/v0.0.3/mem-macos-x86_64.tar.gz"
      sha256 "15b08ce00c6f8ba1e60e4257e4b0e82e632712a0a1c4088e44baf0fce976e14e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.3/mem-macos-arm64.tar.gz"
      sha256 "c391a52cddb7b573cd5efdb1f3c4fd556d446320b101aae0a60a61b3f8864248"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.3/mem-linux-x86_64.tar.gz"
      sha256 "c3bc034fb106656d8246aec8b3533cca1e14fe7211df86d6d967f58bc2b51f8c"
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
