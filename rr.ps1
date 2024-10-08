Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName WindowsBase

# Set volume to maximum
$obj = New-Object -ComObject WScript.Shell
for ($i = 0; $i -lt 50; $i++) {
    $obj.SendKeys([char]175)
}

# Get the full path of the script
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath

# Construct the full path to the video file
$videoPath = Join-Path $scriptDir "rr.mp4"

# Check if the file exists
if (-not (Test-Path $videoPath)) {
    Write-Host "Video file not found: $videoPath"
    exit
}

$window = New-Object System.Windows.Window
$window.WindowStyle = [System.Windows.WindowStyle]::None
$window.ResizeMode = [System.Windows.ResizeMode]::NoResize
$window.WindowState = [System.Windows.WindowState]::Maximized
$window.Topmost = $true

$mediaElement = New-Object System.Windows.Controls.MediaElement
$mediaElement.LoadedBehavior = [System.Windows.Controls.MediaState]::Manual
$mediaElement.UnloadedBehavior = [System.Windows.Controls.MediaState]::Stop
$mediaElement.Volume = 1
$mediaElement.Stretch = [System.Windows.Media.Stretch]::Uniform

$window.Content = $mediaElement

$mediaElement.Add_MediaEnded({
    $window.Close()
})

$window.Add_Loaded({
    $uri = New-Object System.Uri $videoPath, [System.UriKind]::Absolute
    $mediaElement.Source = $uri
    $mediaElement.Play()
})

$window.ShowDialog()