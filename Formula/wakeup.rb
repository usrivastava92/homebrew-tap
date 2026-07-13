class Wakeup < Formula
  desc "A tiny, auditable caffeinate-compatible keep-awake CLI"
  homepage "https://github.com/usrivastava92/wakeup"
  license "MIT"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.3/wakeup-macos-arm64"
      sha256 "66729b529ba629a9c25e11621b0a18226cc123fe167b8ac822fe1678c23ade3b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.3/wakeup-macos-x86_64"
      sha256 "5284dcc2c4ed1d9ec4c4c48885378af5c6a27a3fac7d92aba60d2e575555e9e0"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.3/wakeup-linux-x86_64"
      sha256 "6d41be48d3526a487876fdb27e7773c0a2d7002bde05cdaa0a5a4d8e04f28228"
    end
    if Hardware::CPU.arm?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.3/wakeup-linux-arm64"
      sha256 "3c198370733f5ead93d2939750a84e1121a67e6804639f987da5bb6d7aaa7c5f"
    end
  end

  def install
    bin.install Dir["wakeup-*"].first => "wakeup"
  end

  test do
    system "#{bin}/wakeup", "--version"
  end
end
