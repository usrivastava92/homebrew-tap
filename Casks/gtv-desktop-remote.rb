cask "gtv-desktop-remote" do
  version "1.6.2"
  sha256 "46e78e097b26e38ba5b6ed844fc48b7c626d7d60ae9e462645cb78687b15050a"

  url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v1.6.2/GTV%20Remote-1.6.2-mac-arm64.dmg"
  name "GTV Remote"
  desc "Desktop remote for Google TV and Android TV"
  homepage "https://github.com/usrivastava92/gtv-desktop-remote"

  app "GTV Remote.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/GTV Remote.app"]
  end

  caveats do
    <<~EOS
      GTV Remote is open source and intentionally not notarized - we don't pay
      Apple's $99/year gatekeeping tax to ship free software.

      This cask automatically removes the quarantine flag during install, so the
      app should launch normally. If macOS still blocks launch, run:

        sudo xattr -dr com.apple.quarantine "/Applications/GTV Remote.app"

      If launch is still blocked after that, use:
        System Settings -> Privacy & Security -> Open Anyway
    EOS
  end

  zap trash: [
    "~/Library/Application Support/GTV Remote",
    "~/Library/Preferences/com.utkarsh.gtvdesktopremote.plist",
    "~/Library/Saved Application State/com.utkarsh.gtvdesktopremote.savedState",
  ]
end
