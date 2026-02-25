$base_tkg_content_library_uri = "https://wp-content.vmware.com/v2/latest"
$tkg_content_library_lib_url = "${base_tkg_content_library_uri}/lib.json"
$tkg_content_library_items_url = "${base_tkg_content_library_uri}/items.json"

Write-Host -ForegroundColor Cyan "Downloading lib.json"
Invoke-WebRequest $tkg_content_library_lib_url -OutFile "lib.json"

Write-Host -ForegroundColor Cyan "Downloading items.json"
Invoke-WebRequest $tkg_content_library_items_url -OutFile "items.json"

$items = (Get-Content -Raw items.json | ConvertFrom-Json).items

foreach ($item in $items) {
    $itemFolderName = $item.name

    # Create TKr directory
    if(!(Test-Path -Path $itemFolderName)) {
        Write-host -ForegroundColor Cyan "Downloading ${itemFolderName} ..."
        New-Item -ItemType Directory -Path $itemFolderName | Out-Null

        $files = $item.files.hrefs
        foreach ($file in $files) {
            $itemDownloadUrl = "${base_tkg_content_library_uri}/${file}"

            # Download TKr files
            Write-host -ForegroundColor Yellow "Downloading ${file} ..."
            Invoke-WebRequest $itemDownloadUrl -OutFile ${file}
        }
    }
    break
}