#!/usr/bin/env bash

. /opt/esp/entrypoint.sh

set -e

needed_env=$(env | sort | grep -E "^(IDF_|ESP_|PATH)")
export_needed_env=$(echo "$needed_env" | awk '{print "export " $0}')
usb_groups=$(find /dev \( -iname 'ttyACM*' -or -iname 'ttyUSB*' \) -exec stat --format="%G" {} \;)
first_usb_group=$(echo "$usb_groups" | head -n 1)

usermod -aG root ubuntu
usermod -aG dialout ubuntu

mkdir -p /opt/esp/root_managed_components
chmod a+rwx /opt/esp/root_managed_components

echo "$usb_groups" \
    | paste -sd, - \
    | xargs -I{} -- usermod -aG {} ubuntu

cat >> /home/ubuntu/.bashrc <<EOF
# =================================
$export_needed_env
cd /app
EOF

# Optional: change the ESP32 target
# You can speed this up by using `docker commit` to save the target as a layer.
# idf.py set-target esp32c3

# Run with the first USB group. That means the user needs to connect the USB device before running the container.
# You can manually change the group with `newgrp $first_usb_group` after running the container.
su_groups="$(echo "$usb_groups" | awk '{ print "-G ", $0 }')"
su ubuntu -g ubuntu ${su_groups} -l
exit $?
