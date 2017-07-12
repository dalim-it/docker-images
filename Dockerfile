FROM gluster/gluster-centos

ENV SSH_PWD=password

RUN sed -i '/Port 2222/c\Port 22' /etc/ssh/sshd_config

ADD run.sh .
COPY rpcbind.service /etc/systemd/system/
ENTRYPOINT [ "bash","run.sh" ]
