# Preparing a bare bones Debian server

### Shell's goodies (must have)
We consider a freshly installed (vmware standard image) Debian server (8.8 jessie).
In order to find a production context some goodies must be installed.
 * `lsb_release -a  # to obtain the OS version`
 * ````
   apt-get update
   apt-get upgrade
   ````
 * Offer to use sudo
   ````
   apt-get install sudo
   adduser ssh_user sudo    # ssh_user shall be the production account
   apt-get install vim
   ````
   edit /etc/sudoers and, after the line `%sudo   ALL=(ALL:ALL) ALL` add a line `ssh_user ALL=(ALL:ALL) ALL`
 * In case your default language alas happens _not_ to be english (`env | grep LANG`)
   ````
   apt-get install language-pack-us
   dpkg-reconfigure locales
   ````
   and edit root's .bashrc to add the following lines
   ````
   export LANG=en_US.UTF-8
   alias h='history'
   ````
   and `source ~/.bashrc`

### An example of LVM usage
 * Reference: [HowToGeek LVM tutorial](https://www.howtogeek.com/howto/40702/how-to-manage-and-use-lvm-logical-volume-management-in-ubuntu/)

````
# Retrieve the device that you shall use
fdisk -l         

# sdb shall be used for lvm usage
pvcreate /dev/sdb  

# Lists the used group names: chose a new group name not among them
vgdisplay 
# Here we chose to create the `vgdata` group on top of `sdb`
vgcreate vgdata /dev/sdb  
# Assert creation of vgdata went smoothly
vgdisplay       

# Creation of the logical disk (1500 giga bytes in this example and named "Data").
# Note: this should result in the creation of a /dev/vgdata/Data device
lvcreate -n Data -L 1500g vgdata

# Creation of the file system: ext4 allows for dynamical resizing
mkfs -t ext4 /dev/vgdata/Data

# Create a directory as partition mount point
mkdir /Data

# Mount the lvm partition on this new mount point:
mount /dev/vgdata/Data /Data

# Assert mounting went smoothly with
df

# Add the corresponding entry in /etc/fstab file
/dev/vgdata/Data  /Data  ext4    rw,nouser,auto    0       2

# Check integrity of the above edited /etc/fstab
umount /Data
mount /Data

# Reboot your server (just to make sure):
sync; sync; reboot
````

### Extending the logical disk
````
# Retrieve the lvm partition to be extended
vgdisplay

# Add an extra 100 Go to the device
lvextend --size +100G /dev/vgdata/Data

# Inform the (extensible) file system that it has more room
resize2fs /dev/vgdata/Data           
````
