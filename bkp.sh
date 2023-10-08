#!/usr/bin/env bash
ACTION=$1
IN_PATH=$2
OUT_PATH=$3
FILENAME=$4

if ! hash gpg 2>/dev/null; then
    echo "Please install GPG!"
    exit
fi

echo "a: ${ACTION}, in: ${IN_PATH}, out: ${OUT_PATH}, name: ${FILENAME}"
case $ACTION in
    compress)
	echo "tar zcvf - ~/src | gpg -c > ~/Dropbox/bkp/src-$(date +%F-%H%M).tar.gz.gpg"
	echo "tar zcvf - ${IN_PATH} | gpg -c > ${OUT_PATH}/${FILENAME}-$(date +%F-%H%M).tar.gz.gpg"
    ;;
    descompress)
	echo "gpg -o - -d ~/Dropbox/bkp/src-2018-11-29-0947.tar.gz.gpg | tar zxf -"
	echo "gpg -o - -d ${IN_PATH} | tar zxf -"
    ;;
    *)
	echo "command: ${ACTION} not found, sorry! \n\n Exist:\n - compress\n - descompress"
    ;;
esac
