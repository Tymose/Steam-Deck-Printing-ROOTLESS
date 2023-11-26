#!/bin/bash

podman run --replace -d -p 1024:631 -v /var/run/dbus:/var/run/dbus -v /home/deck/print/jobs:/jobs -v /home/deck/print/cups:/etc/cups --name cupsd docker.io/olbat/cupsd #Start container (for robustness will replace current container if it is already running)

konsole -e /bin/bash -c 'echo -e "Sleeping before starting print jobs: 5 seconds" && sleep 5' #Sleeping to allow server to start

podman exec cupsd /bin/bash -c "lpr /jobs/*" #Print all files in ~/jobs directory

konsole -e /bin/bash -c 'echo -e "Sleeping before deleting print jobs: 5 seconds" && sleep 5' #Sleeping before deleting jobs

rm /home/deck/print/jobs/*.* #Removing all pdf files from ~/jobs directory