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
      sha256 "c968de912cb7588272de637a5b0d1ac8f1a91057e70b58c40ce5849ab73c6649"
    end
    if Hardware::CPU.arm?
      url "https://github.com/memovai/memov/releases/download/v0.0.8/mem-macos-arm64.tar.gz"
      sha256 "9eabdb6ddd49893d36046cff897cb11a7ce81df71bf8fe78a999fa539457c522"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/memovai/memov/releases/download/v0.0.8/mem-linux-x86_64.tar.gz"
      sha256 "e88d3f2276722ffdd53d8ce59883908fe960623e7d8b01b628e7e6b3681e9e21"
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
