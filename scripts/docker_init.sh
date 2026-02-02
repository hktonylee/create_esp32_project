#!/usr/bin/env bash

. /opt/esp/entrypoint.sh
set +e

needed_env=$(env | sort | grep -E "^(IDF_|ESP_|PATH)")
export_needed_env=$(echo "$needed_env" | awk '{print "export " $0}')
first_usb_group=$(find /dev \( -iname 'ttyACM*' -or -iname 'ttyUSB*' \) -exec stat --format="%G" {} \; | head -n 1)

usermod -aG root ubuntu
usermod -aG dialout ubuntu

find /dev \( -iname 'ttyACM*' -or -iname 'ttyUSB*' \) -exec stat --format="%G" {} \; \
    | xargs -I{} usermod -aG {} ubuntu

cat >> /home/ubuntu/.bashrc <<EOF
# =================================
$export_needed_env
cd /app
EOF

# Run with the first USB group. That means the user needs to connect the USB device before running the container.
# You can manually change the group with `newgrp $first_usb_group` after running the container.
su ubuntu -g ubuntu ${first_usb_group:+-G $first_usb_group} -l
exit $?
