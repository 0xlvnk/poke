#!/bin/bash
echo "==== SSH User List ===="
cut -d: -f1 /etc/passwd | grep -vE '^(root|sync|shutdown|halt|nobody)' | while read user; do
    exp=$(chage -l $user | grep "Account expires" | awk -F": " '{print $2}')
    echo "• $user (Expires: $exp)"
done
