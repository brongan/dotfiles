#!/bin/bash

# Helpful to read output when debugging
set -eux

# Stop Display Server
USER=brong
XORG_SERVICE="xorg-server@0.service"
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u ${USER})/bus"
sudo -E -u ${USER} systemctl --user stop ${XORG_SERVICE}
sleep 1

# Unbind VTconsoles
for (( i = 0; i < 16; i++)) do   if test -x /sys/class/vtconsole/vtcon${i}; then
	if [ `cat /sys/class/vtconsole/vtcon${i}/name | grep -c "frame buffer"` = 1 ]; then
		echo 0 > /sys/class/vtconsole/vtcon${i}/bind
		echo "Unbinding console ${i}"
		echo $i >> /tmp/vfio-bound-consoles
	fi
fi done

# Unbind EFI-Framebuffer
if test -e "/tmp/vfio-is-nvidia" ; then
	rm -f /tmp/vfio-is-nvidia
fi
if lsmod | grep "nvidia" &> /dev/null ; then
	echo "true" >> /tmp/vfio-is-nvidia
	echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
fi

# Avoid a Race condition by waiting. This can be calibrated to be shorter or longer if required for your system
sleep 5

# Unload all Nvidia drivers
modprobe -r nvidia_drm nvidia_modeset nvidia_uvm nvidia-gpu nvidia i2c_nvidia_gpu nouveau

# Looks like these might need to be unloaded on Ryzen Systems. Not sure yet.
modprobe -r ipmi_devintf ipmi_msghandler

# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_08_00_0
virsh nodedev-detach pci_0000_08_00_1
virsh nodedev-detach pci_0000_08_00_2
virsh nodedev-detach pci_0000_08_00_3

# Load VFIO Kernel Module  
modprobe vfio vfio-pci vfio_iommu_type1

echo "performance" | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
