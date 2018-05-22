#!/bin/bash

#
# Usage: bash check.sh
#
# Purpose: test the reachability from this host of the configured HTTP servers
# for CernVM-FS software repository 'sw.lsst.eu', via the configured proxies
#

if [[ ! -f /etc/cvmfs/domain.d/lsst.eu.conf ]]; then
   echo "file /etc/cvmfs/domain.d/lsst.eu.conf could not be found"
   exit 1
fi

curlCmd=$(command -v curl)
if [[ -z ${curlCmd} ]]; then
   echo "command curl not found"
   exit 1
fi

source /etc/cvmfs/domain.d/lsst.eu.conf

urls=`echo ${CVMFS_SERVER_URL} | sed -e 's/;/ /g' -e 's|@fqrn@|sw.lsst.eu/.cvmfspublished|g'`
proxies=`echo ${CVMFS_HTTP_PROXY} | sed -e 's/|/ /g' -e 's/;/ /g'`

rc=0
for u in ${urls}; do
   for p in ${proxies}; do
      ok=`${curlCmd} --silent --head --proxy ${p} ${u} | grep "HTTP/1.1 200 OK"`
      if [[ -z ${ok} ]]; then
         echo "HTTP HEAD request for $u via proxy $p failed"
         rc=1
      fi
   done
done

exit $rc