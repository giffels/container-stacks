#!/bin/bash
for file in $(ls /scratch/etc/profile.d/*.sh 2>&1 > /dev/null); do
  test -f $file && source $file
done
