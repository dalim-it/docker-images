FROM gluster/gluster-centos

ENV SSH_PWD=password

RUN sed -i '/Port 2222/c\Port 22' /etc/ssh/sshd_config

CMD ["echo","'root:$SSH_PWD'", "|", "chpasswd", "&&", "/usr/lib/systemd/systemd", "--system"]
