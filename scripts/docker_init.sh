#!/usr/bin/env bash

set -e

usermod -aG dialout "$(id -un)"

su ubuntu -g ubuntu
