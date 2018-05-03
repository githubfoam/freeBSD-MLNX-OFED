# FreeBSD-MLNX-OFED
cross-platform Mellanox OFED for FreeBSD (work under progress)
warning:provisioner is not ansible_local due to freebsd synced_folder problem.

Host: Windows 10   
Vagrant VM Guest: FreeBSD-11.1

vagrant up iser-server01   
vagrant destroy iser-server01   
vagrant ssh iser-server01   

download vagrant and install
https://www.vagrantup.com/downloads.html

download oracle VM virtualbox and install
https://www.virtualbox.org/wiki/Downloads

freebsd-11.1
https://app.vagrantup.com/bento/boxes/freebsd-11.1

Make sure you have installed the Mellanox OFED for FreeBSD:
http://www.mellanox.com/page/products_dyn?product_family=193&mtag=freebsd_driver

Mellanox OFED for FreeBSD for ConnectX-4 Release Notes Rev 3.0.0
http://www.mellanox.com/related-docs/prod_software/Mellanox_FreeBSD_Release_Notes_3.0.0.pdf

Mellanox OFED for FreeBSD for ConnectX-4 User Manual Rev 3.0.0
http://www.mellanox.com/related-docs/prod_software/Mellanox_FreeBSD_User_Manual_v3.0.0.pdf

Please refer to the following git repository
https://github.com/sagigrimberg/iser-freebsd

Install iSCSI/iSER by following steps:
- build user-space iscsi tools (iscsid and iscsictl with iSER support)
	$ ./build.sh -u -S <share directory path> -d <install dest dir> \
		-b <bin dir> -s <sbin dir> -m <man dir>
- build kernel space iscsi stack (with iSER support)
	$ ./build.sh -k -S <share directory path> -D <sys directory path>

The following example creates SCSI Direct Access (da) device over iSCSI/iSER protocol vs. remote target:
- steps:
	$ service iscsid start
	$ iscsictl -A -t <target-name> -p <target portal> -T iser In this stage, after the login and initialize stages are finished, an iSCSI/iSER type device (/dev/da<device_id>) is available and ready for data transfer.

The following example removes SCSI Direct Access (da) device over iSCSI/iSER protocol.
- steps:
	$ iscsictl -R -t <target-name>
