# this service uses up too much cpu. 
# It is also of no use with windows updates disabled
if ((Get-Service -name "TrustedInstaller").StartType -eq "Automatic"){
	Set-Service -name "TrustedInstaller" -StartupType "Manual"
}
