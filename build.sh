#!/usr/bin/bash

# Version of the installed VMWare Workstation 
VERSION="$(vmware-installer -l | awk 'FNR==3 {print $2}' | cut -n -d '.' -f 1-3)"

# Grab the zip from the github repo
wget "https://github.com/mkubecek/vmware-host-modules/archive/refs/heads/player-${VERSION}.zip"

# Unzip the zip file
unzip -q player-$VERSION.zip

# Get the build directory
BUILDDIR="$(zipinfo player-$VERSION.zip | sed -n 3p | awk '{print $NF}')"
cd $BUILDDIR

# Build components and then install 
cd vmmon-only && sudo make 
cd ../vmnet-only && sudo make
cd .. && sudo make install 

# Return to the original directory and clean up
cd ..
rm player-$VERSION.zip*
rm -rf "$BUILDDIR"

