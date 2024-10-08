# GitHub repository information
$repo = "adojang/chromos"
$branch = "main"

# Files to download
$files = @("rr.ps1", "rr.mp4")

# Download the files
foreach ($file in $files) {
    $url = "https://raw.githubusercontent.com/$repo/$branch/$file"
    Invoke-WebRequest -Uri $url -OutFile $file
}

# Execute the PowerShell script
& .\rr.ps1