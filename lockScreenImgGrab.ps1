Add-Type -Assembly System.Drawing

$src = "C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets"
$dst = "C:\Users\$env:UserName\Pictures\wallpapers"

if(!(Test-Path -Path $dst )) {
  New-Item -ItemType directory -Path $dst
}

Get-ChildItem $src | Copy-Item -Destination $dst -Force

Get-ChildItem $dst | Foreach-Object {
  $newName = [io.path]::ChangeExtension($_.name, "png")
  $dest = Join-Path -Path $_.Directory.FullName -ChildPath $newName
  Move-Item -Path $_.FullName -Destination $dest -Force
}

Get-ChildItem $dst | Foreach-Object {
  $name = $_.FullName
  try
  {
    $png = New-Object System.Drawing.Bitmap $name
    if (!($png.Width.Equals(1920) -and $png.Height.Equals(1080))) {
        $png.Dispose()
        Remove-Item $name -Force
    }
    else {
        $png.Dispose()
    }
  }
  catch
  {
    $png.Dispose()
    Remove-Item $name -Force
  }
}
