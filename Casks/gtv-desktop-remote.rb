cask "gtv-desktop-remote" do
  version "2.2.0"
  on_arm do
    sha256 "acb493b9a12f3109a9d95403853102e588304688e35d675e47048b30b8bb616f"

    url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v2.2.0/GTV.Remote-2.2.0-mac-arm64.dmg"
  end
  on_intel do
    sha256 "05ada15255b0fbf0f3162f8b13a261fb2cacf79132212133ba3bd14ec5a07cd0"

    url "https://github.com/usrivastava92/gtv-desktop-remote/releases/download/v2.2.0/GTV.Remote-2.2.0-mac-x64.dmg"
  end
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
