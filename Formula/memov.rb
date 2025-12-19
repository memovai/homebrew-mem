# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/IRONICBo/mem-mcp-server"
  version "0.0.12"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.12/mem-macos-x86_64.tar.gz"
      sha256 "20f5918962a583c19cba0d0dc34d75801b8c3827c1445355c076526124a02e1d"
    end
    if Hardware::CPU.arm?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.12/mem-macos-arm64.tar.gz"
      sha256 "b3e94407b4a40b62ca349a8176e4e5beef8f0ad90c30599dcca325354bf67f04"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/IRONICBo/mem-mcp-server/releases/download/v0.0.12/mem-linux-x86_64.tar.gz"
      sha256 "12bb3d7d6dca6093a20bc8105c8dba9204ce4791a365fe5a0efbf97c8b840d60"
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
