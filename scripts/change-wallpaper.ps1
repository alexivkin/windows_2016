# this wallpaper obscures the eval note, so it's not as distracting
if ((Get-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -name 'Wallpaper').Wallpaper -ne "C:\Windows\Web\Screen\img104.jpg"){
	Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value "C:\Windows\Web\Screen\img104.jpg"
	#rundll32.exe user32.dll, UpdatePerUserSystemParameters
}
