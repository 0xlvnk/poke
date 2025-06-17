#!/bin/bash
read -rp "Username to delete: " user
if id "$user" &>/dev/null; then
    userdel "$user"
    echo "User $user deleted."
else
    echo "User not found!"
fi
