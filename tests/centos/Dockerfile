FROM centos:centos7

#
# Install CERN RPM repository and cvmfs client
#
RUN yum install -q -y https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest.noarch.rpm \
    && yum install -q -y cvmfs

#
# Install convenience tools
#
RUN yum install -q -y tree

#
# Add the RPM packages
#
ADD ["./*.rpm", "./"]

RUN yum install -q -y *.rpm

ENTRYPOINT /bin/bash
