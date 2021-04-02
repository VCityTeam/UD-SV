# Downloading Windows XP installation disk image
The Windows XP installation disk image has been archived an can be legally downloaded, along with a public licence key (serial).
The image for Windows XP Pro SP3 (32 bits) can be downloaded at https://archive.org/details/WinXPProSP3x86.
The associated serial is `MRX3F-47B9T-2487J-KWKMF-RPWBY`.

# Installing VirtualBox on Ubuntu 20.04
`sudo apt update sudo apt install virtualbox virtualbox-ext-pack`

## A word about Secure Boot
If you have EFI Secure Boot enabled, be aware that VirtualBox needs some specific kernel modules that will have to be signed for your machine : Machine Owner Key` (MOK).
It adds an extra step to reboot and accept (`enrolling`) the MOK in a specialized pre-boot menu.
If you don't recall enrolling the MOK, you might get some error when trying to start a Virtual Machine (VM):
```
Kernel driver not installed (rc=-1908)
The VirtualBox Linux kernel driver is either not loaded or not set up correctly. Please reinstall virtualbox-dkms package and load the kernel module by executing
'modprobe vboxdrv'
as root.

If your system has EFI Secure Boot enabled you may also need to sign the kernel modules (vboxdrv, vboxnetflt, vboxnetadp, vboxpci) before you can load them. Please see your Linux system's documentation for more information.

where: suplibOsInit what: 3 VERR_VM_DRIVER_NOT_INSTALLED (-1908) - The support driver is not installed. On linux, open returned ENOENT.
```

## Signing kernel modules in case of Secure Boot
The signing process repeated below is detailed by [this post](https://stegard.net/2016/10/virtualbox-secure-boot-ubuntu-fail/).

- Creating a directory to create and store MOK and signing scripts:
  ```
  sudo -i
  mkdir /root/module-signing
  cd /root/module-signing
  openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=YOUR_NAME/"
  chmod 600 MOK.priv
  ```
- Reading of the MOK and defining a temporary password before rebooting and UEFI enrolling menu:
  ```
  mokutil --import /root/module-signing/MOK.der
  ```
- Reboot, enroll the key and enter the previous temporary password.
- Create the script to sign VirtualBox required modules as file `/root/module-signing/sign-vbox-modules` with the following content :
  ```
  #!/bin/bash

  for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
    echo "Signing $modfile"
    /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 \
                                  /root/module-signing/MOK.priv \
                                  /root/module-signing/MOK.der "$modfile"
  done
  ```
- Rights to run the script as root and loading the `vboxdrv` module:
  ```
  sudo -i
  chmod 700 /root/module-signing/sign-vbox-modules
  modprobe vboxdrv
  ```

# Shared repository
In order to share files between the host OS and the VM, a repository can be shared.
Shared folders can be set up in `Settings->Shared Folders`, and should appear as network drives in the VM, in Windows explorer.

Sharing a repository requires installing some supplemental drivers inside the VM but it is furtunately almost automated by VirtualBox.
Once the Windows XP VM has booted, just click on `Devices->Insert Guest Addition CD image` in the VirtualBow window menu, and process with the installation that should start right away.

# Export/import of a virtual machine
A virtual machine can be easily exported as a binary to use it on an other machine or an other host OS.
See the menus `File->Export Appliance` and `File->Import Appliance`, and don't forget to adapt the paths of your shared directories if needed.
