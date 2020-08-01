#!/bin/sh

# From https://github.com/danhn255/dotfiles/blob/master/virtual-machine/qemu.sh
#Location /etc/libvirt/hooks/qemu

#Hooks for libvirt to run when starting or reverting back from win10 virtual machine
# Script for win10
if [[ $1 == "win10" ]]; then
   if [[ $2 == "prepare" ]]; then
	/home/brong/.local/bin/vfio-start.sh
   fi

   if [[ $2 == "release" ]]; then
	/home/brong/.local/bin/vfio-revert.sh
   fi
fi

