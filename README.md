# Windows 2016 server optimized build

This is a [packer](https://www.packer.io/) build environment for the windows server 2016 base VM for Virtual Box hosted on the [Vagrant box catalog](https://app.vagrantup.com/alexivkin/boxes/windows_2016).

The default build based on an eval version of the windows server 2016 (9PBKX-... product key) which is good for 6 months, at which time you can rebuild the system to refresh the trial. Alternatively you can specify your own key and the ISO (see below).

This repo is here for all you security minded people to validate that there is no funny stuff inserted into the resulting VM.

Things that are done during the build:
* Latest updates and virtualbox guest tools are installed
* RDP, UAC and WinRM are enabled
* Telemetry and screensaver are disabled
* Windows defender removed
* Disk cleaned up

External tools used in the build are Microsoft's sdelete and Bleachbit, in script/compact.ps1. sdelete is used because there is no built-in windows way to zero out a disk for the vbox size reduction.

Based on scripts from [Stefan Scherer](https://github.com/StefanScherer/packer-windows) and [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows).

The image is about 10% smaller than that from Stefan Scherer, which is 10% smaller than Joe's.

# Building
`packer build packer.json`

A trial windows server 2016 ISO will be downloaded from Microsoft and cached on the first build. Once the build is done, add it to the list of availabe boxes:

`vagrant box add alexivkin/windows_2016 windows_2016_virtualbox.box`

Then you can use the box in your vagrant machines by specifying the following in the Vagrantfile

`config.vm.box = "alexivkin/windows_2016"`

## Product Keys
If you would like to use a retail or a volume license ISO, you need to update the `UserData` ->`ProductKey` in the Autounattend.xml and then run packer on a pre-downloaded iso like this:

`packer build --only=virtualbox-iso --var iso_url=./iso/en_windows_server_2016_x64_dvd_9718492.iso --var iso_checksum=F185197AF68FAE4F0E06510A4579FC511BA27616 --var iso_checksum_type=sha1 --var autounattend=./Autounattend.xml packer.json`

### How long is my trial Windows Server VM is valid for?
The validity can be see in the event log -> application -> security-SPP, event ID 1037

## Testing and development
The Autonunattend.xml script will install all the windows updates during the build, which is a **very** time consuming process. You  might want to disable this functionality by uncommenting the `WITHOUT WINDOWS UPDATES` and commenting out the `WITH WINDOWS UPDATES` sections.
Alternatively you can copy Autonunattend.xml.noupdates or Autonunattend.xml.withupdates over Autonunattend.xml

Use `./publish` to push your creation to the Vagrant Cloud
