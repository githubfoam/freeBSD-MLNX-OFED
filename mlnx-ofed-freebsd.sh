#preps for freebsd
sudo pkg update -y
sudo pkg install -y wget bmake
# Mellanox OFED for FreeBSD for ConnectX-4 User Manual Rev 3.0.0
# http://www.mellanox.com/related-docs/prod_software/Mellanox_FreeBSD_User_Manual_v3.0.0.pdf
# To install the driver software, kernel sources must be installed on the machine.fetch kernel sources /tmp dir
# method1
# svn checkout https://svn.freebsd.org/base/releng/`uname -r | cut -d'-' -f1,1` /usr/src
# method2
fetch -o /tmp ftp://ftp.freebsd.org/pub/`uname -s`/releases/`uname -m`/`uname -r | cut -d'-' -f1,2`/src.txz
# Extract the tarball
tar -C / -xvf /tmp/src.txz
# Compile and install linuxapi module under /sys/modules/linuxapi
# linuxapi module becomes linuxkpi module. Missing in Mellanox_FreeBSD_User_Manual_v3.0.0.pdf
cd /usr/src/sys/modules/linuxkpi
sudo make
# load linuxkpi module
sudo kldload linuxkpi
# Download the tarball image to your host Mellanox Driver for FreeBSD-3.0.0
wget http://www.mellanox.com/downloads/Drivers/freebsd_mlx5en.tar.gz
#cd /usr/home/vagrant
# Extract the tarball
tar xfvz freebsd_mlx5en.tar.gz
cd /usr/home/vagrant/freebsd_mlx5en/mlx5_modules/mlx5
#Clean any previous dependencies
bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys clean cleandepend
 # Compile the mlx5_core module
 # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys
 # Install the mlx5_core module
 # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys install
 # Load the mlx5_core module
 # kldload mlx5
 # load a module on reboot, add "mlx5_load="YES" to the '/boot/loader.conf' file
 # sed -e '/autoboot_delay="-1"/a\'$'\n''mlx5_load="YES"' /boot/loader.conf
 # Go to the mlx5en directory
 # cd /usr/home/vagrant/freebsd_mlx5en/mlx5_modules/mlx5en
 # Clean any previous dependencies
 # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys clean cleandepend
 # Compile the mlx5en module
 # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys
 # Install the mlx5_core module
 # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys install
 # Load the mlx5en module
 # kldload mlx5en
 # load a module on reboot, add "mlx5en_load="YES" to the '/boot/loader.conf' file
 # sed -e '/autoboot_delay="-1"/a\'$'\n''mlx5en_load="YES"' /boot/loader.conf
