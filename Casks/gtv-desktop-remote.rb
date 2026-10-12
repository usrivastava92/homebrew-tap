cask "gtv-desktop-remote" do
  version "2.0.0"
  sha256 "6002fb2ed0379864e6f011fb32a073aa5cecfe3826c887d3c5b9d824af7fb268"

  url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v2.0.0/GTV.Remote-2.0.0-mac-arm64.dmg"
  name "GTV Remote"
  desc "Desktop remote for Google TV and Android TV"
  homepage "https://github.com/usrivastava92/gtv-desktop-remote"

  app "GTV Remote.app"

  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/GTV Remote.app"]
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
