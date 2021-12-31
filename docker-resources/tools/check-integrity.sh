#!/bin/bash
#
# Making sure that certain files exist and work as expected.
#

echo ">"
echo "=>"
echo "==>"
echo "===>"
echo "====> INTEGRITY CHECK $1"
echo "$PATH"
echo "(If this fails, then ldconfig is not present.)"
find / -name ldconfig | grep bin
echo "====> END INTEGRITY CHECK $1"
echo "===>"
echo "==>"
echo "=>"
echo ">"
