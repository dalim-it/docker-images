#!/bin/sh
modprobe fuse
lsmod | grep fuse
dmesg | grep -i fuse

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
VOL_DIR='/vol'

if [[ -z ${GLUSTER_HOST+x} ]]; then
    printf "${RED}WARN:${NC} Environment variable GLUSTER_HOST must be defined !\n"
    exit 1;
fi

if [[ -z ${GLUSTER_VOLUME+x} ]]; then
    printf "${RED}WARN:${NC} Environment variable GLUSTER_VOLUME must be defined !\n"
    exit 1;
fi

echo "$GLUSTER_HOST:/$GLUSTER_VOLUME $VOL_DIR/$GLUSTER_VOLUME glusterfs defaults,_netdev 0 0" >i> /etc/fstab
mkdir -p $VOL_DIR/$GLUSTER_VOLUME
mount $VOL_DIR/$GLUSTER_VOLUME
rc=$?

term_handler() {
    printf "\n${YELLOW}SIGTERM received ${NC}\xE2\x9A\xA1\n"
    umount $VOL_DIR/$GLUSTER_VOLUME
    if [[ $? -eq 0 ]]; then
	printf "\n${GREEN}Unmount succeed ! ${NC}\xF0\x9F\x98\x80 \n\n"
    else
	printf "\n${RED}Unount failed ! ${NC}\xF0\x9F\x98\xAD \n\n"
    fi
    exit 0
}
trap 'kill ${!}; term_handler' SIGTERM

logfile=/var/log/glusterfs$VOL_DIR-$GLUSTER_VOLUME.log
if [[ $rc -eq 0 ]]; then
    printf "\n${GREEN}Mount succeed ! ${NC}\xF0\x9F\x98\x80 \n\n"
    tail -F $logfile & wait ${!}
else
    printf "\n${RED}Mount failed ! ${NC}\xF0\x9F\x98\xAD \n\n"
    cat $logfile
fi
