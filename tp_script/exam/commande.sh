#!/bin/bash

sudo fdisk -l /dev/sda | head -1 | cut -d " " -f 5

sudo fdisk -l /dev/sda | grep "/dev/sda\b"