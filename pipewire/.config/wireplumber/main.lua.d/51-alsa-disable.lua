rule = {
	matches = {
		{
			{ "device.name", "equals", "alsa_card.usb-046d_HD_Pro_Webcam_C920_E733F5AF-02" },
		},
	},
	apply_properties = {
		["device.disabled"] = true,
	},
}

table.insert(alsa_monitor.rules, rule)
