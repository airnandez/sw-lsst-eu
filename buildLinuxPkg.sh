#!/bin/bash

#
# Import version
#
source 'version.sh'
version=$(pkgVersion)

#
# Package name
#
packageName="cvmfs-config-lsst"

#
# Prepare the output directory
#
outputDir=${SCRATCH:-/tmp}
mkdir -p ${outputDir}

#
# Clean up first
#
rm -f ${outputDir}/${packageName}*.{rpm,deb}

#
# Build RPM and DEB packages
#
for out in rpm deb; do
     fpm  --name ${packageName} \
          --version ${version} \
          --depends cvmfs \
          --description "Configuration files for CernVM-FS file system /cvmfs/sw.lsst.eu" \
          --maintainer "Fabio Hernandez (fabio@in2p3.fr)" \
          --url "https://sw.lsst.eu" \
          --license "Apache v2.0" \
          --vendor "CNRS / IN2P3 computing center (CC-IN2P3)" \
          --architecture all \
          --output-type ${out} \
          --input-type dir \
          --package ${outputDir} \
          --config-files ./etc \
          ./etc
done

#
# Set file ownership, if necessary
#
userName="lsstsw"
if getent passwd ${userName} > /dev/null 2>&1; then
     chown  ${userName}:${userName}  ${outputDir}/${packageName}*.{rpm,deb}
fi
