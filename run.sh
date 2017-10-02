#!/bin/bash

echo 'root:$SSH_PWD' | chpasswd
/usr/lib/systemd/systemd --system
