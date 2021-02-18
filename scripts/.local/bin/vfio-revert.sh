#!/bin/bash

# From https://github.com/danhn255/dotfiles/blob/master/virtual-machine/vfio-revert.sh
set -eux

# Unload VFIO-PCI Kernel Driver
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio
  
# Re-Bind GPU to Nvidia Driver
virsh nodedev-reattach pci_0000_08_00_3
virsh nodedev-reattach pci_0000_08_00_2
virsh nodedev-reattach pci_0000_08_00_1
virsh nodedev-reattach pci_0000_08_00_0

# Rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind

nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# Reset to normal CPU governor
echo "schedutil" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Reload Nvidia drivers
modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia-gpu nvidia i2c_nvidia_gpu nouveau

# Restart Display Manager
systemctl restart sysinit.target

