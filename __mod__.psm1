
$ErrorActionPreference = "Stop"

git.exe submodule update --init --recursive --remote --force

New-Item `
    -Path "$PSScriptRoot\.ruby\msys64" `
    -Value "$PSScriptRoot\.msys2" `
    -ItemType Junction `
    -ErrorAction SilentlyContinue

$env:RI_DEVKIT = "$PSScriptRoot\.msys2"

$env:PATH += ";$PSScriptRoot\.ruby\bin"
$env:PATH += ";$PSScriptRoot\.nodejs"
$env:PATH += ";$env:RI_DEVKIT\usr\bin"
$env:PATH += ";$env:RI_DEVKIT\mingw64\bin"

$env:GEM_HOME = "$PSScriptRoot\.ruby\lib\ruby\gems\2.6.0"
$env:GEM_PATH = "$PSScriptRoot\.ruby\lib\ruby\gems\2.6.0"

$env:BUNDLE_GEMFILE = "$PSScriptRoot\website\Gemfile"

$env:MSYSTEM   = "MINGW64"

