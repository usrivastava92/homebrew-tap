cask "gtv-desktop-remote" do
  version "1.5.0"
  sha256 "f1e375e0faef2f42eafd91ad308999a523888026de6b3c9129165cb7c7f38ca1"

  url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v1.5.0/GTV%20Remote-1.5.0-mac-arm64.dmg"
  name "GTV Remote"
  desc "Desktop remote for Google TV and Android TV"
  homepage "https://github.com/usrivastava92/gtv-desktop-remote"

  app "GTV Remote.app"

  zap trash: [
    "~/Library/Application Support/GTV Remote",
    "~/Library/Preferences/com.utkarsh.gtvdesktopremote.plist",
    "~/Library/Saved Application State/com.utkarsh.gtvdesktopremote.savedState",
  ]
end
