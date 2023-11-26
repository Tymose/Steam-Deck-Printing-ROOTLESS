# Steam Deck Rootless Printing

## Disclaimer

This is proof of concept of method to add printer (I've tested only network printer) and print from Steam Deck without need to change any root files or invoking root privileges. This one should survive system upgrades though although requires initial setup (using script) and run script every time when you will want to print something.

There are serval other methods like unlocking Steam Deck and installing CUPS server directly (will not survive system upgrade), installing second operating system (require dual booting) or probably other ones that I did not hear about.

## Credits

Container I'm using in this method was created and is maintained by **olbat** and all credits for it goes to him.

<https://github.com/olbat>

<https://hub.docker.com/r/olbat/cupsd>

## 1. Prerequisites

- Steam OS 3.5 (tested on 3.5.5) - versions over 3.5.0 are coming with Podman preinstalled that is essential for this method

- Internet access - script need to be able to download container from Docker Hub

## 2. General idea

- There are methods to unlock root access and install CUPS server but after each system update procedure will need to be repeated as system will be overwritten

- Steam OS 3.5 introduced preinstalled Podman that allows to install and run containers (like e.g. CUPS print server)

- I did not found method to add printer in Desktop mode but it allows to print to PDF file (that can be saved in specific folder). Such file can be put in specific folder (in this approach I'm using "/home/deck/print/jobs/" location).

- Simple script is created to print PDFs from that specific folder ("home/deck/print/jobs/" location for this scripts) on containerized CUPS server instead

## 3. Installation and usage instructions

1. Download scripts "initial-run.sh" and "pod-print.sh" from "Desktop-Scripts" folder and save them to Desktop

2. Change **BOTH** files attribute to executable (click LMB on file > click on "Properties" > click on "Permissions" tab > mark "Is Executable" > click "OK" button)

3. Run (double click) "initial-run.sh" script

  > [!NOTE]
  > After running this script you can safely delete it
  
  > [!NOTE]
  > If page with admin properties will not open in your browser and file will be deleted than you open it using <http://127.0.0.1:1024>

4. Configure your printer as you would normally in CUPS and make sure it is set up as **Default** one there (see "cups-example-configuration.md" for example config of network printer)

  > [!CAUTION]
  > For script to work Default Printer need to be set up. Otherwise script neet to be modified with -p option to give printer name
  
  > [!CAUTION]
  > Make sure that "printers.conf" file showed up in "/home/deck/print/cups/" folder after you finish configuration (can take few seconds after finishing configuration)
  
  > [!NOTE]
  > At some point server might ask you about user / password - it is `print` / `print`
  
  > [!NOTE]
  > You should set up printer you'd like to use as default by going "Printers" tab > click on your printer name > click on "Administration" option (NOT Tab) > chose "Set As Server Default"
  
  > [!NOTE]
  > As port 631 is being redirected to 1024 from container (without root privileges we cannot bind ports under 1024) some steps might fail when CUPS server configuration pages will be reloading. In such case simply go back to <http://127.0.0.1:1024> and continue. Port can be changed in CUPS config file but would later require redirection to proper port using lpr command so for simplicity I'm skipping it.

5. Print something on your Steam Deck saving resultant PDF to folder "/home/deck/print/jobs"

  > [!NOTE]
  > At this step you need to set up how your print should look like (like which pages to print etc.) - this is first and last step for modifications
  
  6. Run script "pod-print.sh" to print all files in "/home/deck/print/jobs" folder
  
  > [!CAUTION]
  > All files in "/home/deck/print/jobs" folder will be deleted after run (script is not checking if run was successful though). If you want to leave all PDFs in folder after run put # on beginning of last line of script (before "rm" command) or delete this line completely

## 4. Thats all
