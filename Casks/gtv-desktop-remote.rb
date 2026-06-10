cask "gtv-desktop-remote" do
  version "1.6.1"
  sha256 "6e7036896b8d58e950633458b9a7644e72cb78c7dedc4f25e4f10d63427e30bd"

  url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v1.6.1/GTV.Remote-1.6.1-mac-arm64.dmg"
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
