$parentDir = 'C:\TestUserRedirectedFolder'

Write-Output $parentDir

$dirs = Get-ChildItem $parentDir | Where-Object {$_.psiscontainer}

foreach ($dir in $dirs){
    write-output $dir.fullname
    takeown.exe /F $($dir.fullname) /R /D Y |out-null
    icacls.exe $($dir.fullname) /reset /T /C /L /Q
    icacls.exe $($dir.fullname) /grant ($($dir.basename) + ':(OI)(CI)F') /C /L /Q
    icacls.exe $($dir.fullname) /setowner $($dir.basename) /T /C /L /Q
}