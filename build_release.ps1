# Build release APKs split par architecture
# arm64-v8a (~42 MB), armeabi-v7a (~40 MB), x86_64 (~43 MB)
# Les APKs sont dans : build/app/outputs/flutter-apk/

flutter build apk --release --split-per-abi

Write-Host ""
Write-Host "APKs generees :"
Get-ChildItem "build\app\outputs\flutter-apk\app-*-release.apk" |
    Select-Object Name, @{Name="Taille";Expression={"{0:N1} MB" -f ($_.Length / 1MB)}} |
    Format-Table -AutoSize
