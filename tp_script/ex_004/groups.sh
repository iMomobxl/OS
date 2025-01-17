#!/bin/bash

grep -E "\b$(whoami)\b" /etc/group | cut -d : -f 1 | tr "\n" " " ; echo