# typed: false
# frozen_string_literal: true

class Memov < Formula
  desc "AI-powered version control tool - memory layer for AI coding agents"
  homepage "https://github.com/memovai/memov"
  version "0.0.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/memovai/memov/releases/download/v0.0.5/mem-macos-x86_64.tar.gz"
      sha256 "c07f8dc445d48e7862ba2934fb4d0d80aab3d424e428f5aed35be72f5bfc0361"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.5/mem-macos-arm64.tar.gz"
      sha256 "41a08f787210d9ed5cfab02fe14468c33bc15744e8307cf139d736a3616b502e"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.5/mem-linux-x86_64.tar.gz"
      sha256 "4264cea20ec79f8f400eca63167389708205cd512028abe6a33db215505098a7"
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
