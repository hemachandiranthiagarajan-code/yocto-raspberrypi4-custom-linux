ROOTFS_POSTPROCESS_COMMAND += "configure_wifi_autostart; "

configure_wifi_autostart() {
    install -d ${IMAGE_ROOTFS}/etc
    install -d ${IMAGE_ROOTFS}/etc/init.d
    install -d ${IMAGE_ROOTFS}/etc/rcS.d

    printf '%s\n' \
"ctrl_interface=/var/run/wpa_supplicant" \
"ctrl_interface_group=0" \
"update_config=1" \
"country=IN" \
"" \
"network={" \
"    ssid=\"YOUR_WIFI_SSID\"" \
"    psk=\"YOUR_WIFI_PASSWORD\"" \
"    key_mgmt=WPA-PSK" \
"}" \
> ${IMAGE_ROOTFS}/etc/wpa_supplicant.conf

    chmod 600 ${IMAGE_ROOTFS}/etc/wpa_supplicant.conf

    printf '%s\n' \
"#!/bin/sh" \
"case \"\$1\" in" \
"  start)" \
"    echo \"Starting Wi-Fi auto connect...\"" \
"    modprobe brcmfmac 2>/dev/null || true" \
"    ip link set wlan0 up 2>/dev/null || true" \
"    sleep 2" \
"    killall wpa_supplicant 2>/dev/null || true" \
"    wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf" \
"    sleep 5" \
"    udhcpc -i wlan0 -q -t 20 2>/dev/null || true" \
"    ;;" \
"  stop)" \
"    killall wpa_supplicant 2>/dev/null || true" \
"    ;;" \
"esac" \
"exit 0" \
> ${IMAGE_ROOTFS}/etc/init.d/wifi-connect

    chmod 755 ${IMAGE_ROOTFS}/etc/init.d/wifi-connect
    ln -sf ../init.d/wifi-connect ${IMAGE_ROOTFS}/etc/rcS.d/S99wifi-connect
}
