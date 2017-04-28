FROM gluster/gluster-centos

ENV SSH_PWD=password

RUN sed -i '/Port 2222/c\Port 22' /etc/ssh/sshd_config

ADD run.sh .
ENTRYPOINT [ "bash","run.sh" ]
