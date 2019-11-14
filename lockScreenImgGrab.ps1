Add-Type -Assembly System.Drawing

$src = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$dst = "C:\Users\$env:UserName\Pictures\wallpapers"

if(!(Test-Path -Path $dst )) {
    New-Item -ItemType directory -Path $dst
}

Get-ChildItem $src | Foreach-Object {
    $name = $_.FullName
    $nameOnly = $_.Name
    $dirName = $_.Directory.FullName

    try {
        $png = New-Object System.Drawing.Bitmap $name
        if (!($png.Width.Equals(1920) -and $png.Height.Equals(1080))) {
            $png.Dispose()
        }
        else {
            $png.Dispose()
            $checkPath = $dst + "\" + $nameOnly + ".png"
            if (!(Test-Path $checkPath)) {
                Write-Host "New Image: $nameOnly"

                $newName = [io.path]::ChangeExtension($nameOnly, "png")
                $dest = Join-Path -Path $dst -ChildPath $newName
                Copy-Item $name -Destination $dest
                $processName = $dst+"\"+$newName
                Start-Process $processName
           }
        }
    }
    catch {
        $png.Dispose()
    }
}
