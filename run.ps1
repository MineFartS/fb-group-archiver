param( [Switch]$Force )

Import-Module "$PSScriptRoot/__mod__.psm1" -Force

Push-Location "$PSScriptRoot\website"

if ($Force) {
    Remove-Item "Gemfile.lock" -Force
    Remove-Item "vendor\bundle\ruby\" -Recurse -Force
    bundle clean --force
}

ruby --disable-gems -S gem install bundler:2.4.19 `
    --no-document `
    --install-dir $env:GEM_HOME `
    --bindir "$PSScriptRoot\.ruby\bin"

Write-Output "Running Bundler dependency tree synchronization..."
bundle install

Write-Output "Initializing PostgreSQL database pipelines..."
bundle exec rails db:setup posts:import

Write-Output "Hosting site alive at http://127.0.0.1:3000"
bundle exec rails server -b 127.0.0.1 -p 3000

Pop-Location

