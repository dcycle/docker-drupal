#!/bin/bash
#
# Making sure that certain files exist and work as expected.
#

echo "====> INTEGRITY CHECK $1"
echo "$PATH"
find / -name ldconfig
echo "====> END INTEGRITY CHECK $1"
