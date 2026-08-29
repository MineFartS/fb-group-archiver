git.exe submodule update --init --recursive --remote

function Invoke-RubyScript ([string]$script, [Parameter(ValueFromRemainingArguments)]$cmdargs) {
    Start-Process `
        -FilePath (Get-Item "$PSScriptRoot\.ruby\bin\$script.*" | Select-Object -First 1).FullName `
        -ArgumentList $cmdargs `
        -Wait -NoNewWindow
}

New-Item `
    -Path "$PSScriptRoot\.ruby\msys64" `
    -Value "$PSScriptRoot\.msys2" `
    -ItemType Junction `
    -ErrorAction SilentlyContinue

$env:RI_DEVKIT = "$PSScriptRoot\.msys2"
$env:RUBY_DLL_PATH = "$env:RI_DEVKIT\mingw64\bin"
$env:MSYSTEM = "MINGW64"

$env:MAKE = "make CFLAGS='-Wno-error=incompatible-pointer-types -fpermissive'"

$env:PATH += ";$PSScriptRoot\.ruby\bin"
$env:PATH += ";$PSScriptRoot\.nodejs"
$env:PATH += ";$env:RI_DEVKIT\usr\bin"
$env:PATH += ";$env:RUBY_DLL_PATH"

