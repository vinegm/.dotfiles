#!/bin/bash

# Check Linux distribution
if [ ! -f /etc/os-release ]; then
    echo "Cannot determine Linux distribution."
    exit 1
fi

source /etc/os-release
DISTRO=$ID

echo "Identified distribution: $DISTRO"

case "$DISTRO" in
    "ubuntu")
        bash ./cleanups/ubuntu_cleanup.sh
        ;;
    "arch linux")
        bash ./cleanups/arch_cleanup.sh
        ;;
    *)

        echo "Unsupported distribution"
        exit 1
        ;;
esac

echo "System cleanup complete!"

