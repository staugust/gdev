#!/bin/sh

if [ ! $(lsmod | grep nvidia | wc -l) -eq 0 ] ; then
	driver='nvi'
	DRIVER='NVI'
elif [ ! $(lsmod | grep nouveau | wc -l) -eq 0 ] ; then
	driver='nouveau'
	DRIVER='NOUVEAU'
elif [ ! $(lsmod | grep pscnv | wc -l) -eq 0 ] ; then
	driver='pscnv'
	DRIVER='PSCNV'
else
	echo "Device driver not found"
	exit
fi

echo "Device driver detected: $driver"

# create Driver.mk
cat > Driver.mk << EOF
#
# Copyright (C) Shinpei Kato
# All Rights Reserved
#
# This is automatically generated by autogen.sh script.
#

DRIVER_NAME=$driver
EOF

# create gdev_autogen.h
cat > gdev_autogen.h << EOF
/*
 * Copyright (C) Shinpei Kato
 * All Rights Reserved
 *
 * This is automatically generated by autogen.sh script.
 *
 */

#define GDEV_DRIVER_$DRIVER
EOF