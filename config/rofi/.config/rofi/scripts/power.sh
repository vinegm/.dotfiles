#!/bin/bash

if [ -z "$@" ]; then
  echo -en "Suspend\0icon\x1fsystem-suspend\n"
  echo -en "Lock\0icon\x1fsystem-lock-screen\n"
  echo -en "Logout\0icon\x1fsystem-log-out\n"
  echo -en "Hibernate\0icon\x1fsystem-suspend-hibernate\n"
  echo -en "Reboot\0icon\x1fsystem-reboot\n"
  echo -en "Shutdown\0icon\x1fsystem-shutdown\n"
else
  case "$1" in
    Shutdown)
      shutdown now
    ;;
    Logout)
      i3-msg exit
    ;;
    Reboot)
      reboot
    ;;
    Suspend)
      systemctl suspend
    ;;
    Lock)
      i3lock --nofork
    ;;
    Hibernate)
      systemctl hibernate
    ;;
    *)
      echo "Usage: $0 {Shutdown|Logout|Reboot|Suspend|Lock|Hibernate}"
    ;;
  esac
fi

