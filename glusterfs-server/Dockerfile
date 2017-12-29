FROM gluster/gluster-centos

ENV SSH_PWD=you_want_to_change_this_password

RUN sed -i '/Port 2222/c\Port 22' /etc/ssh/sshd_config

ADD run.sh .
COPY rpcbind.service /etc/systemd/system/
# reference : http://lists.gluster.org/pipermail/gluster-users/2014-November/019394.html

ENTRYPOINT [ "bash","run.sh" ]
