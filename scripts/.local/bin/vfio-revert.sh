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

# Rebind VT consoles (adapted from https://www.kernel.org/doc/Documentation/fb/fbcon.txt)
input="/tmp/vfio-bound-consoles"
while read consoleNumber; do
  if test -x /sys/class/vtconsole/vtcon${consoleNumber}; then
      if [ `cat /sys/class/vtconsole/vtcon${consoleNumber}/name | grep -c "frame buffer"` = 1 ]; then
        echo "Rebinding console ${consoleNumber}"
        echo 1 > /sys/class/vtconsole/vtcon${consoleNumber}/bind
      fi
  fi
done < "$input"

if test -e "/tmp/vfio-is-nvidia" ; then
  echo "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/bind
fi

nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# Reset to normal CPU governor
echo "schedutil" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

# Reload Nvidia drivers
modprobe nvidia_drm nvidia_modeset nvidia_uvm nvidia-gpu nvidia i2c_nvidia_gpu nouveau ipmi_devintf ipmi_msghandler

# Restart Display Manager
systemctl restart sysinit.target

