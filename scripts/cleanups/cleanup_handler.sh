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
        bash ./ubuntu_cleanup.sh
        ;;
    "arch")
        bash ./arch_cleanup.sh
        ;;
    *)

        echo "Unsupported distribution"
        exit 1
        ;;
esac

echo "System cleanup complete!"

