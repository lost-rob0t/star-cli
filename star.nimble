# Package

version       = "0.1.0"
author        = "nsaspy"
description   = "Manage star intel Operations and automations from the command line"
license       = "MIT"
srcDir        = "src"
bin           = @["star"]


# Dependencies

requires "nim >= 1.6.14"
requires "mycouch"
requires "https://github.com/lost-rob0t/starintel-doc.nim.git >= 0.7.3"
# Broken!
# Will Be re-added, just a temp fix
# requires "https://github.com/lost-rob0t/starRouter.git"
requires "cligen"

task install, "installs star-cli":
  switch("define", "release")
  switch("define", "ssl")
  switch("opt", "speed")
  setCommand "c"
