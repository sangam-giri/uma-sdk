param(
    [string]$message
)

# Set the color for success message
$color = "Green"

# Colorize the message
Write-Host $message -ForegroundColor $color
