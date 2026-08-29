Import-Module "$PSScriptRoot/__mod__.psm1" -Force

Set-Location $PSScriptRoot

Push-Location "website"

Invoke-RubyScript bundle install

Invoke-RubyScript rails db:setup posts:import

Pop-Location

