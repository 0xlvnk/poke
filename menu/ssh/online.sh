#!/bin/bash
echo "===== User Aktif & IP Login ====="
who | awk '{print $1, $5}' | sort | uniq
