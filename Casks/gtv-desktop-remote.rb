cask "gtv-desktop-remote" do
  version "1.0.4"
  sha256 "d6ca0601691ebf26a039e4a11e501dcfe533acb7125abbef383fe2e2df81da55"

  url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v#{version}/GTV.Remote-#{version}-mac-arm64.dmg"
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
