FROM ubuntu:16.04

RUN apt-get update

#
# Install CERN RPM repository and cvmfs client
#
RUN apt-get update \
    && apt-get --assume-yes install lsb-release \
    && apt-get --assume-yes install curl \
    && apt-get --assume-yes install tree

RUN curl -s -o /tmp/cvmfs-release-latest_all.deb https://ecsft.cern.ch/dist/cvmfs/cvmfs-release/cvmfs-release-latest_all.deb \
	&& dpkg -i /tmp/cvmfs-release-latest_all.deb \
	&& apt-get update

RUN apt-get --yes install cvmfs

#
# Install DEB package
#
ADD ["./*.deb", "./"]
RUN dpkg -i  *.deb

ENTRYPOINT /bin/bash
