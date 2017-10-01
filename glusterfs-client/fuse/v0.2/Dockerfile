FROM centos:7
RUN yum -y install openssh-server wget fuse fuse-libs openib libibverbs glusterfs glusterfs-fuse
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
