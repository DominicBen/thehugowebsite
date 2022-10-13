#!/bin/sh
USER=root
HOST=192.168.1.50
DIR=/var/www/html/   # the directory where your web site files should go

hugo && rsync -avz --delete public/ ${USER}@${HOST}:${DIR}

exit 0
