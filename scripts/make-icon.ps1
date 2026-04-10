# Monochrome Dew — Icon resizer
# Usage: pwsh ./scripts/make-icon.ps1 <source-image-path> [output-size]
#
# Takes any square-ish source image and produces icon.png (default 128x128)
# at the project root. Uses .NET System.Drawing, no external dependencies.

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$SourcePath,

    [Parameter(Position=1)]
    [int]$Size = 128
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $SourcePath)) {
    Write-Error "Source image not found: $SourcePath"
    exit 1
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$outputPath = Join-Path $projectRoot "icon.png"

Write-Host "Reading: $SourcePath"
$source = [System.Drawing.Image]::FromFile((Resolve-Path $SourcePath))
Write-Host "Source dimensions: $($source.Width)x$($source.Height)"

# Center-crop to square (in case source is not perfectly square)
$side = [Math]::Min($source.Width, $source.Height)
$offsetX = [int](($source.Width - $side) / 2)
$offsetY = [int](($source.Height - $side) / 2)

# Create target bitmap with high-quality resampling
$target = New-Object System.Drawing.Bitmap $Size, $Size
$graphics = [System.Drawing.Graphics]::FromImage($target)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$graphics.PixelOffsetMode   = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

$destRect = New-Object System.Drawing.Rectangle 0, 0, $Size, $Size
$srcRect  = New-Object System.Drawing.Rectangle $offsetX, $offsetY, $side, $side
$graphics.DrawImage($source, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

$target.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$graphics.Dispose()
$target.Dispose()
$source.Dispose()

Write-Host "Saved: $outputPath ($Size x $Size)"
