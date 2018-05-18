#!/bin/bash

#
# Import version
#
source 'version.sh'
version=$(pkgVersion)

#
# Package id
#
packageId="eu.lsst.sw.cvmfs.config"

#
# Package file name
#
packageFileName="sw-lsst-eu-cvmfs-config_${version}.pkg"

#
# Build the package
#
sudo pkgbuild  \
	--root ./etc  \
	--identifier ${packageId} \
	--version ${version}  \
	--install-location /etc \
	${packageFileName}