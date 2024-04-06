$env:MIX_ENV="prod"
$env:PORT="4271"

Write-Host "Building..."

$CFGD = Resolve-Path "~/.config/events"

if (!(Test-Path -Path $CFGD)) {
    New-Item -ItemType Directory -Force -Path $CFGD
}

if (!(Test-Path -Path "$CFGD/base")) {
    mix phx.gen.secret | Out-File "$CFGD/base"
}

if (!(Test-Path -Path "$CFGD/dbpw")) {
    Add-Type -AssemblyName System.Web
    [System.Web.Security.Membership]::GeneratePassword(12, 1) | Out-File "$CFGD/dbpw"
}

$env:SECRET_KEY_BASE = Get-Content "$CFGD/base"

$DATABASE_PASSWORD = Get-Content "$CFGD/dbpw"
$env:DATABASE_URL="ecto://events:$DATABASE_PASSWORD@localhost/events"

Write-Host "Migrating..."
mix ecto.migrate

npm install --prefix ./assets
npm run deploy --prefix ./assets
mix phx.digest

Write-Host "Generating release..."
mix release

Write-Host "Starting app..."
& "$PWD/start.ps1"