# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
config.vm.box ="bento/freebsd-11.1"


 config.vm.define "iser-server01" do |config|
   config.vm.hostname = "iser-server01"
   config.vm.network "private_network", ip: "192.168.44.12"


         #freebsd shared_folder problem
         config.vm.synced_folder ".", "/vagrant_data", disabled: true
         #config.ssh.shell = "/bin/sh"
         # Bootstrap pkgng
         #config.vm.provision "shell", inline: "env ASSUME_ALWAYS_YES=YES pkg bootstrap"


          config.vm.provision "shell", inline: <<-SHELL
          echo "=================================================================================="
          echo "=====================preps for freebsd============================================"
          echo "=================================================================================="
          sleep 6
          pkg update -y
          pkg install -y wget bmake
          echo "=================================================================================="
          echo "===================kernel sources must be installed==============================="
          echo "=================================================================================="
          sleep 6
          # Mellanox OFED for FreeBSD for ConnectX-4 User Manual Rev 3.0.0
          # http://www.mellanox.com/related-docs/prod_software/Mellanox_FreeBSD_User_Manual_v3.0.0.pdf
          # To install the driver software, kernel sources must be installed on the machine.fetch kernel sources /tmp dir
          fetch -o /tmp ftp://ftp.freebsd.org/pub/`uname -s`/releases/`uname -m`/`uname -r | cut -d'-' -f1,2`/src.txz
          # Extract the tarball
           tar -C / -xvf /tmp/src.txz
          # Compile and install linuxapi module under /sys/modules/linuxapi
          # linuxapi module becomes linuxkpi module. Missing in Mellanox_FreeBSD_User_Manual_v3.0.0.pdf
           cd /usr/src/sys/modules/linuxkpi
           make
          # load linuxkpi module
           kldload linuxkpi
          echo "=================================================================================="
          kldstat | grep linuxkpi.ko
          echo "=================================================================================="
          echo "======Download the tarball image Mellanox Driver for FreeBSD-3.0.0================"
          echo "=================================================================================="
          sleep 6
          # Download the tarball image to your host Mellanox Driver for FreeBSD-3.0.0
           # cd /usr/home/vagrant
           # wget http://www.mellanox.com/downloads/Drivers/freebsd_mlx5en.tar.gz
          wget http://www.mellanox.com/downloads/Drivers/freebsd_mlx5en.tar.gz -O /usr/home/vagrant/freebsd_mlx5en.tar.gz
          # chmod 777 /usr/home/vagrant/freebsd_mlx5en.tar.gz
          SHELL


          config.vm.provision "shell", inline: <<-SHELL
          # Extract the tarball
          # tar xfvz /usr/home/vagrant/freebsd_mlx5en.tar.gz
          # tar xfvz freebsd_mlx5en.tar.gz
          tar -C /usr/home/vagrant -xvf freebsd_mlx5en.tar.gz
          echo "=================================================================================="
          echo "===================Compile the mlx5_core module==================================="
          echo "=================================================================================="
          sleep 6
          cd /usr/home/vagrant/freebsd_mlx5en/mlx5_modules/mlx5
          #Clean any previous dependencies
           bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys clean cleandepend
           # # Compile the mlx5_core module
           #  bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys
           # Install the mlx5_core module
           # bmake -m $HEAD/share/mk SYSDIR=$HEAD/sys install
           # Load the mlx5_core module
           # kldload mlx5
           # echo "=================================================================================="
           # echo "===================Compile the mlx5en_core module================================="
           # echo "=================================================================================="
           # sleep 6
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
           echo "=================================================================================="
           echo "===================MELLANOX OFED FOR FREEBSD-11.1 READY==========================="
           echo "=================================================================================="
          SHELL

           config.vm.provider "virtualbox" do |vb|
              vb.gui = false
              vb.memory = "1024"
              vb.name = "iser-server01"
            end
 end


end
