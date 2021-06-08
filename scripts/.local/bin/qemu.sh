#!/bin/sh

#Hooks for libvirt to run when starting or reverting back from win10 virtual machine
VM_NAME="win10"
if [[ $1 == ${VM_NAME} ]]; then
   if [[ $2 == "prepare" ]]; then
	/home/brong/.local/bin/vfio-start.sh | tee -a /var/log/libvirt/custom_hooks.log
   fi

   if [[ $2 == "release" ]]; then
	/home/brong/.local/bin/vfio-revert.sh | tee -a /var/log/libvirt/custom_hooks.log
   fi
fi

