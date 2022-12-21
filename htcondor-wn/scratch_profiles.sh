#!/bin/bash
for file in $(ls /scratch/etc/profile.d/*.sh); do
  test -f $file && source $file
done
