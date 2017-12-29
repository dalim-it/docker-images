#!/bin/bash

echo $SSH_PWD | passwd --stdin root
/usr/lib/systemd/systemd --system
