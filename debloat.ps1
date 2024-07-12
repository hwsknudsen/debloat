$Junk = "xbox|phone|disney|skype|spotify|groove|zune|mixedreality|tiktok|prime|soundrecorder|bingweather!3dviewer|LinkedInforWindows"
#"Removing apps for this user only."
$packages = Get-AppxPackage | Where-Object {  $_.Name -match $Junk  } | Where-Object -Property NonRemovable -eq $false 
foreach ($appx in $packages) {
    "Removing {0}" -f $appx.name
    Remove-AppxPackage $appx   
}
""
#"Removing apps for all users."
$packages = Get-AppxPackage -AllUsers | Where-Object {  $_.Name -match $Junk  } | Where-Object -Property NonRemovable -eq $false 
foreach ($appx in $packages) {
    "Removing {0}" -f $appx.name
    Remove-AppxPackage $appx -AllUsers 
}
""
#"Removing provisioned apps."
$packages = Get-AppxProvisionedPackage -Online | Where-Object {  $_.DisplayName -match $Junk  }
foreach ($appx in $packages) {
    "Removing {0}" -f $appx.displayname
    Remove-AppxProvisionedPackage -online -allusers -PackageName $appx.PackageName 
}
