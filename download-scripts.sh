#!/bin/bash

echo "Downloading scripts to ~/Desktop..."
rm -f ~/Desktop/initial-run.sh
rm -f ~/Desktop/pod-print.sh
wget -P ~/Desktop https://raw.githubusercontent.com/Tymose/Steam-Deck-Printing-ROOTLESS/main/Desktop-Scripts/initial-run.sh
wget -P ~/Desktop https://raw.githubusercontent.com/Tymose/Steam-Deck-Printing-ROOTLESS/main/Desktop-Scripts/pod-print.sh
chmod +x ~/Desktop/initial-run.sh
chmod +x ~/Desktop/pod-print.sh
