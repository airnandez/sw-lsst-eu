#!/bin/bash

#
# Usage: sudo bash configure.sh
#
# This script configures a CernVM FS client to access the
# LSST software repository /cvmfs/sw.lsst.eu. The CernVM-FS
# client software must be previously installed.
#

usage() {
    echo "Usage: sudo bash configure.sh"
}

#
# We must run as 'root'
#
if [[ $EUID -ne 0 ]]; then
   usage
   exit 1
fi

#
# Execute 'cvmfs_config setup'
#
cvmfscfg=$(command -v cvmfs_config)
if [[ -z ${cvmfscfg} ]] || [[ ! -x ${cvmfscfg} ]]; then
   echo "Could not find CernVM FS configuration command 'cvmfs_config'"
   exit 1
fi
${cvmfscfg} setup
if [ $? -ne 0 ]; then
   exit 1
fi

#
# Copy configuration files to their destination under
# /etc/cvmfs
#
srcDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
destDir='/'
toInstall="etc/cvmfs/domain.d etc/cvmfs/keys/lsst.eu"
for dir in ${toInstall}; do
   dest=$(readlink -m ${destDir}/${dir})
   install -d ${dest}
   install --backup --compare --mode=u=r,g=r,o=r -D ${srcDir}/${dir}/* ${dest}
done

#
# Perform system-specific tasks
#
thisOS=`uname`
if [ "$thisOS" == "Linux" ]; then
   # Use 'cvmfs_config' to check the configuration
   result=`${cvmfscfg} chksetup`
   if [ "$result" != "OK" ]; then
      echo "There was an error checking your CernVM FS configuration:"
      echo $result
      exit 1
   fi
elif [ "$thisOS" == "Darwin" ]; then
   # On MacOS X, create the mount directory
   mkdir -p /cvmfs/sw.lsst.eu
fi

exit 0
