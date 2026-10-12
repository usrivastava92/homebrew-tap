# frozen_string_literal: true

require "cask/cask_loader"
require "fileutils"
require "open3"
require "stringio"
require "tmpdir"

# Use Homebrew's actual loader, artifact dispatch, sandbox and xattr executable.
# Never install the released app or write to /Applications/the Caskroom.
def xattr(*args)
  output, error, status = Open3.capture3("/usr/bin/xattr", *args.map(&:to_s))
  raise "xattr failed: #{error}" unless status.success?

  output
end

def assert(condition, message)
  raise message unless condition
end

Dir.mktmpdir("gtv postflight smoke ") do |directory|
  appdir = Pathname(directory)/"Custom Applications With Spaces"
  app = appdir/"GTV Remote.app"
  nested = app/"Contents/Resources/fixture.txt"
  neighbour = appdir/"Unrelated.app"
  FileUtils.mkdir_p(nested.dirname)
  FileUtils.mkdir_p(neighbour)
  nested.write("isolated fixture, not a real application\n")

  config = Cask::Config.new(explicit: { appdir: appdir.to_s })
  warnings = StringIO.new
  previous_stderr = $stderr
  begin
    $stderr = warnings
    cask = Cask::CaskLoader::FromPathLoader.new(
      Pathname(__dir__).parent/"Casks/gtv-desktop-remote.rb",
    ).load(config: config)
  ensure
    $stderr = previous_stderr
  end
  assert(warnings.string.empty?, "Cask loading emitted warnings: #{warnings.string}")

  hook = cask.artifacts.find { |artifact| artifact.is_a?(Cask::Artifact::PostflightSteps) }

  quarantine = "0081;00000000;HomebrewSmoke;00000000-0000-0000-0000-000000000000"
  [app, nested, neighbour].each { |path| xattr("-w", "com.apple.quarantine", quarantine, path) }
  xattr("-w", "org.gtv.smoke", "preserve", nested)

  # Exercise initial quarantine removal, then an already-unquarantined app.
  2.times do
    hook.install_phase
    [app, nested].each do |path|
      assert(!xattr(path).lines.map(&:strip).include?("com.apple.quarantine"),
             "Quarantine was not recursively removed from #{path}")
    end
    assert(xattr("-p", "org.gtv.smoke", nested).strip == "preserve", "Unrelated attribute changed")
    assert(xattr("-p", "com.apple.quarantine", neighbour).strip == quarantine, "Unrelated app changed")
  end

  # An installation-only run must not execute during artifact uninstallation.
  xattr("-w", "com.apple.quarantine", quarantine, app)
  hook.uninstall_phase
  assert(xattr("-p", "com.apple.quarantine", app).strip == quarantine, "Postflight ran during uninstall")
end

puts "PASS: warning-free Homebrew loading; real sandboxed postflight removes only fixture quarantine; custom appdir spaces and lifecycle isolation preserved"
