# Web based Rasperry Pi Hamclock with 7 inch touch display

## Prerequisites

### Tools and Network
- wireless LAN with internet connection
- any Linux box for installation (alternative Windows Note book mit WSL2 running Ubuntu Linux)

### Hardware
- Rasperry Pi with WLAN connectivity and HDMI output (e.g. Pi zero w)
- HDMI touch screen (e.g. [WAVESHARE 7inch HDMI LCD (C)](https://www.waveshare.com/wiki/7inch_HDMI_LCD_(C)))
- HDMI(male) to Mini HDMI(male) connection cable,
- Micro USB(male) to Micro USB(male) connection cable with
integrated on-the-go adapter
- 5V / 2A USB power supply
- USB to micro USB power supply connection cable
- micro sd card (e.g. 32GB Sandisk High endurance, 100 MB/s read, 40 MB/s write)

### Software
- [Rapberry Pi imager](https://www.raspberrypi.com/software/) 
- [Hamclock software of Clearskyinstitute](https://www.clearskyinstitute.com/ham/HamClock/)
- scripting from this project

## Step by Step

1. **Hardware Setup**
    - assemble the display
    - mount Pi on display
    - connect display and Pi using connection cables
    
2. **Raspberry headless setup**
    - start Pi imager and install image (e.g. Pi OS Lite (32 bit) ) on your sd card.
    - during installationprocess enter desired Pi user and password and WLAN name and access password
    - create an empty file named "ssh" in the root directory of your micro SD card (this tells PI to accept ssh connections after booting)
    - append display configuration (e.g. content of file "append-to-config.txt" to file "config.txt"
    - eject micro SD card from workstation and insert it into Pi's micro SD slot
    - Power up Pi by connecting to power supply
    - Wait until Pi completed its initialization routine, you should see the log on the screen. This may take a while ...
    - ping Pi on the net: you should see Pi answering
    - open a remote connection with ssh to Pi sing user name and password: You will do the following steps over ssh.
    - upgrade the system:

            $ sudo apt update
            $ sudo apt full-upgrade

    - install surf (a simple web browser)

            $ sudo apt install surf
            $ sudo apt-get install lightdm
            $ sudo raspi-config