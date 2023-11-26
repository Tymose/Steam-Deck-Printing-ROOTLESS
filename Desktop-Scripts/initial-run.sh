#!/bin/bash

mkdir -p /home/deck/print/jobs #Creating directory for pdfs in home/print

konsole -e /bin/bash -c 'podman run -d -v /var/run/dbus:/var/run/dbus --name cupsd docker.io/olbat/cupsd' #Initial creation of print server using podman

konsole -e /bin/bash -c 'echo -e "Sleeping before copying config files: 5 seconds" && sleep 5' #Sleeping to allow server to start for first time

podman cp cupsd:/etc/cups ~/print #Copying server config for persistence
podman run --replace -d -p 1024:631 -v /var/run/dbus:/var/run/dbus -v /home/deck/print/jobs:/jobs -v /home/deck/print/cups:/etc/cups --name cupsd docker.io/olbat/cupsd #Creating print server using podman

konsole -e /bin/bash -c 'echo -e "Sleeping before starting browser: 5 seconds" && sleep 5' #Sleeping to allow server to start

xdg-open http://127.0.0.1:1024 #Opening print server page for configuration

konsole -e /bin/bash -c 'echo -e "This file (initial-run.sh) will be deleted now.\nPlease configure CUPS server using browser (http://127.0.0.1:1024)." && sleep 15' #Sleeping to allow server to start

rm ./initial-run.sh