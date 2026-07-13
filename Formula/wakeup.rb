class Wakeup < Formula
  desc "A tiny, auditable caffeinate-compatible keep-awake CLI"
  homepage "https://github.com/usrivastava92/wakeup"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.0/wakeup-macos-arm64"
      sha256 "0eebca531f761d64b193d679ad3ece38000d0db50b2f34162bf4b9b73e0c9f44"
    else
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.0/wakeup-macos-x86_64"
      sha256 "a75616621cc7414cf60590cac088f57ad40a529c174dc000aaf3f376b9b5c098"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/usrivastava92/wakeup/releases/download/v0.1.0/wakeup-linux-x86_64"
      sha256 "939f7c5a137e9d6709de6c865335cc36f34ee36bf2993d04736f094588f7d4cf"
    end
  end

  def install
    bin.install Dir["wakeup-*"].first => "wakeup"
  end

  test do
    system "#{bin}/wakeup", "--version"
  end
end
