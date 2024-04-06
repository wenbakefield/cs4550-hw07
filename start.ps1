$env:MIX_ENV="prod"
$env:PORT="4271"

$CFGD = Resolve-Path "~/.config/events"

if (!(Test-Path -Path $CFGD)) {
    Write-Host "Configuration directory not found"
    exit 1
}

if (!(Test-Path -Path "$CFGD/base")) {
    Write-Host "run deploy first"
    exit 1
}

$env:SECRET_KEY_BASE = Get-Content "$CFGD/base"

$APP_PATH="_build/prod/rel/events/bin/events"

if (!(Test-Path -Path $APP_PATH)) {
    Write-Host "Application not found. Run deploy first."
    exit 1
}

Write-Host "Stopping old copy of app, if any..."

& $APP_PATH stop

Write-Host "Starting app..."

& $APP_PATH start