#!/usr/bin/env bash

set -e

usermod -aG root ubuntu
usermod -aG dialout "root"
usermod -aG dialout "$(id -un)"

chmod -R go+rw /root
chmod go+rwx /root

cat >> /root/.bashrc <<EOF
# =================================
# https://github.com/espressif/esp-idf/blob/master/tools/docker/Dockerfile
. /opt/esp/entrypoint.sh
EOF

su ubuntu -g ubuntu -m
