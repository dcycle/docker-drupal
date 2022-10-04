#!/bin/bash
#
# Make sure we can install and uninstal modules.
#
set -e

CANDIDATE=/scripts/confirm-install-uninstall-"$1".sh

if [ -f "$CANDIDATE" ]; then
  "$CANDIDATE"
fi
