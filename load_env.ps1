# load_env.ps1
if (Test-Path .env) {
    Get-Content .env | Where-Object { $_ -match '=' -and $_ -notmatch '^\s*#' } | ForEach-Object {
        $name, $value = $_.Split('=', 2)
        # Remove surrounding quotes if they exist
        $value = $value.Trim().Trim('"').Trim("'")
        Set-Content -Path "env:\$($name.Trim())" -Value $value
    }
    Write-Host ".env loaded" -ForegroundColor Green
} else {
    Write-Warning ".env file not found"
}