#!/bin/bash

# Usage: bash install.sh

#
# We must run as 'root'
#
if [[ $EUID -ne 0 ]]; then
    usage
    exit 1
fi

installOnCentOS() {
    # Add CERN package repository
    yum install -q -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm

    # Install CernVM FS
    yum install -q -y cvmfs
}

installOnUbuntu() {
    # Add CERN package repository
    apt-get install lsb-release
    wget https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb
    dpkg -i cvmfs-release-latest_all.deb
    rm -f cvmfs-release-latest_all.deb
    apt-get update

    # Install CernVM FS
    apt install cvmfs
}


version=`head -1 /proc/version`
distrib="unknown"
if [[ $version =~ "Red Hat" ]]; then
    distrib="centos"
elif [[ $version =~ "Ubuntu" ]]; then
    distrib="ubuntu"
fi

case $distrib in 
    centos)
        ;;
    
    ubuntu)
        ;;

    unknown)
        echo "Could not determine this distribution"
        exit 1
        ;;
esac

