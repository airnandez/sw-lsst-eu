FROM centos:centos7

#
# Install 'fpm' dependencies
#
RUN yum install -q -y ruby-devel gcc make rpm-build rubygems

#
# Install 'fpm'
#
RUN gem install --no-ri --no-rdoc fpm

#
# Create non-privileged user
#
ENV username="lsstsw"
RUN useradd --create-home --uid 1000 --user-group --home-dir /home/${username} ${username}

#
# Add files needed to build the packages
#
WORKDIR /home/${username}
ADD ["package-for-linux.sh", "version.sh", "./"]
ADD ["etc/", "./etc/"]

ENTRYPOINT /home/${username}/buildLinuxPkg.sh
