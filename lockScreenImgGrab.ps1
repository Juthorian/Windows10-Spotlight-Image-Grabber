Add-Type -Assembly System.Drawing

$src = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$dst = "C:\Users\$env:UserName\Desktop\assets"
$dst2 = "C:\Users\$env:UserName\Pictures\wallpapers"

if(!(Test-Path -Path $dst )) {
    New-Item -ItemType directory -Path $dst
}

Get-ChildItem $src | Copy-Item -Destination $dst -Force

Get-ChildItem $dst | Rename-item -newname { [io.path]::ChangeExtension($_.name, "png") }

Get-ChildItem $dst | Foreach-Object {
    $png = New-Object System.Drawing.Bitmap $_.FullName

    if ($png.Width.Equals(1920) -and $png.Height.Equals(1080)) {
        Copy-Item $_.FullName -Destination $dst2 -Force
    }

    $png.Dispose()
}

Get-ChildItem -Path $dst | Remove-Item -force
Remove-Item $dst -Force
