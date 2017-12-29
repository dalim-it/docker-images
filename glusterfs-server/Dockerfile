FROM gluster/gluster-centos:gluster3u9_centos7

ENV SSH_PWD=you_want_to_change_this_password

COPY rpcbind.service /etc/systemd/system/
# reference : http://lists.gluster.org/pipermail/gluster-users/2014-November/019394.html

COPY run.sh /

RUN chmod +x /run.sh \
    && sed -i '/Port 2222/c\Port 22' /etc/ssh/sshd_config

ENTRYPOINT /run.sh
