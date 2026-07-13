class Wakeup < Formula
  desc "A tiny, auditable caffeinate-compatible keep-awake CLI"
  homepage "https://github.com/usrivastava92/wakeup"
  license "MIT"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.2/wakeup-macos-arm64"
      sha256 "88d6ffbb16423ea2ba93b2919c1debf368ff2a45c67042e6f7edd5f5c32f1fed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.2/wakeup-macos-x86_64"
      sha256 "bebf043f1a34add645bfb4adc2a203bff9b5c8a9a9ead89e6756ffd0d6b08406"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.2/wakeup-linux-x86_64"
      sha256 "70290e7384cb3182fbd1479c8dc9df1ce4f7ce431ab82289b73423e51795e897"
    end
    if Hardware::CPU.arm?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.2/wakeup-linux-arm64"
      sha256 "f27d78cc7c5a058f2354b05f5336fd1a15dfb84d292b65adea2488bfb3c65a8d"
    end
  end

  def install
    bin.install Dir["wakeup-*"].first => "wakeup"
  end

  test do
    system "#{bin}/wakeup", "--version"
  end
end
