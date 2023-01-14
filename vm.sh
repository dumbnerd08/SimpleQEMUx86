#!/bin/bash
cd virtual-machines || mkdir virtual-machines; cd virtual-machines
read -p "Welcome! Press 1 to create a new virtual machine or 2 to load an existing virtual machine: " menu
if [ $menu -eq 1 ]
then
read -p "Name of your new virtual machine: " name
mkdir $name
cd $name
read -p "Hard drive size (GB): " hdasize
qemu-img create -f qcow2 "${name}.img" "${hdasize}G"
read -p "Number of CPUs: " cpus
read -p "Amount of RAM (MB): " ramsize
read -p "Path to your CDROM image or ISO, from / (including suffix: iso, img, etc.): " cdrompath
qemu-system-x86_64 -enable-kvm -cpu host -machine accel=kvm -smp $cpus -boot order=dc -m "${ramsize}M" -cdrom $cdrompath -hda ${name}.img -name $name & echo "VM loaded successfully. Exiting terminal.";sleep 3;exit
elif [ $menu -eq 2 ]
then
	ls	
	read -p "Input the name of your virtual machine listed above: " vmname
	cd $vmname
	read -p "Number of CPUs: " cpus
read -p "Amount of RAM (MB): " ramsize
	qemu-system-x86_64 -enable-kvm -cpu host -machine accel=kvm -smp $cpus -m "${ramsize}M" -hda ${vmname}.img -name $vmname & echo "VM loaded successfully. Exiting terminal.";sleep 3;exit
else
	echo "I don't believe that you followed the instructions. You will receive another chance, but heed this warning."
	./$0
	sleep 1
	exit
fi
