# GlusterFS client sidekick for Docker
A Docker image which package a GlusterFS client designed to be used as a sidekick container.

## Usage
Add `SYS_ADMIN` [capability](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities) and bind device `/dev/fuse`.
 
Then set environment variable `GLUSTER_HOST ` and `GLUSTER_VOLUME` and your data will be mounted into `/vol/${GLUSTER_VOLUME}`.

In order to have it mounted on host you will also need to set [bind propagation](https://docs.docker.com/storage/bind-mounts/#configure-bind-propagation) to `shared`.

All inclusive example: `docker run -d -v /tmp/my-gluster-vol:/vol/my-gluster-vol:shared --device /dev/fuse --cap-add SYS_ADMIN -e GLUSTER_HOST=my-gluster-server.local.domain -e GLUSTER_VOLUME=my-gluster-vol dalimit/glusterfs-client:fuse`
