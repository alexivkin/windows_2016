# should be stopped already - net stop wuauserv
Remove-Item -Recurse -Force C:\Windows\SoftwareDistribution\Download
mkdir C:\Windows\SoftwareDistribution\Download
# net start wuauserv

(New-Object System.Net.WebClient).DownloadFile('https://download.bleachbit.org/BleachBit-2.0-portable.zip', 'C:\Windows\Temp\BleachBit-2.0-portable.zip')

# not using the temp folder because bleachbit will attempt to clean the temp folder
Expand-Archive C:\Windows\Temp\BleachBit-2.0-portable.zip -DestinationPath C:\

C:\BleachBit-Portable\bleachbit_console.exe --clean deepscan.backup deepscan.ds_store deepscan.thumbs_db deepscan.tmp internet_explorer.cookies internet_explorer.forms internet_explorer.history internet_explorer.temporary_files system.clipboard system.custom system.logs system.memory_dump system.muicache system.prefetch system.recycle_bin system.tmp system.updates windows_defender.history windows_explorer.mru windows_explorer.recent_documents windows_explorer.run windows_explorer.search_history windows_explorer.thumbnails
# free-disk_space causes erros
# C:\BleachBit-Portable\bleachbit_console.exe --clean system.free_disk_space

Remove-Item C:\BleachBit-Portable -Force -Recurse

Optimize-Volume -DriveLetter C -Defrag

(New-Object System.Net.WebClient).DownloadFile('https://vagrantboxes.blob.core.windows.net/box/sdelete/v1.6.1/sdelete.exe', 'C:\Windows\Temp\sdelete.exe')
## %SystemRoot%\System32\
reg.exe ADD HKCU\Software\Sysinternals\SDelete /v EulaAccepted /t REG_DWORD /d 1 /f
#Set-ItemProperty "HKCU:\Software\Sysinternals\SDelete" -Name EulaAccepted -Value 1 -Type DWord
C:\Windows\Temp\sdelete.exe -q -z C:
rm C:\Windows\Temp\sdelete.exe
