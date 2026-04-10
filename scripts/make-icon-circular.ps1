# Monochrome Dew — Smart circular icon extractor
#
# Usage: pwsh ./scripts/make-icon-circular.ps1 <source> [size] [darkThreshold]
#
# Detects the darkest connected region (e.g. a black disc bezel) in an
# image, extracts it with transparent background around the inscribed
# circle, and resizes to a square icon.

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$SourcePath,

    [Parameter(Position=1)]
    [int]$Size = 128,

    [Parameter(Position=2)]
    [int]$DarkThreshold = 120,

    [Parameter(Position=3)]
    [double]$BottomExcludeRatio = 0.12
)

Add-Type -AssemblyName System.Drawing

if (-not (Test-Path $SourcePath)) {
    Write-Error "Source image not found: $SourcePath"
    exit 1
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$outputPath = Join-Path $projectRoot "icon.png"

$absPath = (Resolve-Path $SourcePath).Path
Write-Host "Reading: $absPath"
$source = New-Object System.Drawing.Bitmap $absPath
$w = $source.Width
$h = $source.Height
Write-Host "Source dimensions: ${w}x${h}"

# ---- Fast pixel extraction ----
$rect = New-Object System.Drawing.Rectangle 0, 0, $w, $h
$lockMode = [System.Drawing.Imaging.ImageLockMode]::ReadOnly
$pixelFormat = [System.Drawing.Imaging.PixelFormat]::Format32bppArgb
$data = $source.LockBits($rect, $lockMode, $pixelFormat)
$stride = $data.Stride
[int]$totalBytes = $stride * $h
$pixels = [byte[]]::new($totalBytes)
[System.Runtime.InteropServices.Marshal]::Copy([System.IntPtr]$data.Scan0, [byte[]]$pixels, [int]0, [int]$totalBytes)
$source.UnlockBits($data)

# ---- Strategy: find pixels darker than DarkThreshold brightness ----
# Brightness = R+G+B, threshold means "sum below this is considered dark"
# The disc's black bezel will dominate, background gray won't.
$maxYScan = [int]($h * (1.0 - $BottomExcludeRatio))
$minX = $w
$maxX = 0
$minY = $h
$maxY = 0
$darkCount = 0

for ($y = 0; $y -lt $maxYScan; $y++) {
    $rowOffset = $y * $stride
    for ($x = 0; $x -lt $w; $x++) {
        $i = $rowOffset + $x * 4
        $brightness = [int]$pixels[$i] + [int]$pixels[$i + 1] + [int]$pixels[$i + 2]
        if ($brightness -lt $DarkThreshold) {
            $darkCount++
            if ($x -lt $minX) { $minX = $x }
            if ($x -gt $maxX) { $maxX = $x }
            if ($y -lt $minY) { $minY = $y }
            if ($y -gt $maxY) { $maxY = $y }
        }
    }
}

Write-Host "Dark pixel count: $darkCount"

if ($darkCount -lt 100 -or $minX -ge $maxX -or $minY -ge $maxY) {
    Write-Warning "Dark region detection insufficient. Falling back to centered square."
    $side = [int]([Math]::Min($w, $h) * 0.9)
    $minX = [int](($w - $side) / 2)
    $minY = [int](($h - $side) / 2)
    $maxX = $minX + $side
    $maxY = $minY + $side
}

Write-Host "Detected bounding box: ($minX,$minY) - ($maxX,$maxY)"

# ---- Compute circle from bounding box ----
$cx = ($minX + $maxX) / 2.0
$cy = ($minY + $maxY) / 2.0
# Use the largest dimension / 2 for the radius so the full disc is included
$radius = [Math]::Max(($maxX - $minX), ($maxY - $minY)) / 2.0
Write-Host "Circle: center=($cx,$cy) radius=$radius"

# ---- Create masked bitmap ----
$side = [int]($radius * 2)
$cropX = [int]($cx - $radius)
$cropY = [int]($cy - $radius)

$masked = New-Object System.Drawing.Bitmap $side, $side, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($masked)
$g.Clear([System.Drawing.Color]::Transparent)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

$path = New-Object System.Drawing.Drawing2D.GraphicsPath
$path.AddEllipse(0, 0, $side, $side)
$g.SetClip($path)

$srcRect = New-Object System.Drawing.Rectangle $cropX, $cropY, $side, $side
$destRect = New-Object System.Drawing.Rectangle 0, 0, $side, $side
$g.DrawImage($source, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)

$g.Dispose()

# ---- Resize to target size ----
$final = New-Object System.Drawing.Bitmap $Size, $Size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$fg = [System.Drawing.Graphics]::FromImage($final)
$fg.Clear([System.Drawing.Color]::Transparent)
$fg.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$fg.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
$fg.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
$fg.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
$fg.DrawImage($masked, 0, 0, $Size, $Size)

$final.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)

$fg.Dispose()
$final.Dispose()
$masked.Dispose()
$source.Dispose()

Write-Host "Saved: $outputPath (${Size}x${Size}, transparent background)"
