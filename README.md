# Web based Rasperry Pi Hamclock with 7 inch touch display

## Prerequisites

### Tools and Dev Environment
- A wireless LAN with internet connectivity
- Any kind of Linux box as workstation for installation and administration:
    <dl>
    <dt><em>Linux</em></dt>
    <dd>The new version of this product costs significantly less than the previous one!</li></ul>
    <dt><strong>Easier to use</strong></dt>
    <dd>We've changed the product so that it's much easier to use!</dd>
    <dt><strong>Safe for kids</strong></dt>
    <dd>You can leave your kids alone in a room with this product and they won't get hurt (not a guarantee).</dd>
    </dl>

 (alternative Windows WSL2 running Ubuntu Linux)

### Hardware
- Any Rasperry Pi with WLAN connectivity, HDMI display port and USB data/power port. (e.g. [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/))
- HDMI touch screen with USB data/power port (e.g. [WAVESHARE 7inch HDMI LCD (C)](https://www.waveshare.com/wiki/7inch_HDMI_LCD_(C)))
- HDMI diplay connector (HDMI male to mini HDMI male)
- USB data/power connector (micro USB male to micro USB male on-the-go)
- USB power supply (5V, 2A)
- USB power cable (USB male to micro USB male)
- micro sd card (e.g. 32GB Sandisk High endurance, 100 MB/s read, 40 MB/s write)

### Software
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- [rpi-hamclock-web](https://github.com/bubiwahn/rpi-hamclock-web) (this project)
- VNC client software (e.g. [Real VNC](https://www.realvnc.com/en/connect/download/viewer/)) (optional)

## Step by Step Setup

### Hardware Setup

- Assemble the display
- Mount Pi piggyback on display's backside
- Connect display and Pi using the connection cables

### Raspberry Pi headless setup

Start Pi imager on your workstation and install a suitable boot image for your model on the micro SD card. (In my case, Raspberry Pi OS (Legacy, 32 bit)).

During installationprocess enter desired Pi user and password as well as WLAN name and access password

Create an empty file named "ssh" in the root directory of your micro SD card (this tells PI to accept ssh connections after booting)

Append display configuration (e.g. content of file "append-to-config.txt") to file "config.txt"

Eject micro SD card from workstation and insert it into Pi's micro SD slot

Plug in power supply and power up Pi by connecting it with the power cable.

Wait until Pi completed initial setup. This may take a while, I suggest a coffee break ... Eventually, you will see the desktop on the screen.

Ping Pi from your workstation: You should see Pi answering

Open a Linux console on your workstation log into Pi with user and password

    ssh user@hamclock

 After ssh connection is etablished update and reboot the system:

    sudo apt update
    sudo apt full-upgrade
    sudo shutdown -r now


### Raspberry Pi Configuration

Once the Pi is set up and updated, you may want to configure it according your needs. This can be done with a dedicated the configuration tool *raspi-config*. The command

    sudo raspi-config

opens up the interface and allows you to set system parameters interactively. At least, you will want to enable *VNC* in the section *Interface Options*. This allows you to admin Pi via VNC, which might be more comfortable and intuitive than doing it with plain ssh.

After VNC is available, you can either
- connect via VNC and open an Xterminal on the Pi desktop, or
- continue with ssh.

### Hamclock Web Installation

Installation and adminstration of RPi Hamclock relies on Git. In order to make git available, issue the following commands after replacing the placeholders *&lt;your name&gt;* and *&lt;your email&gt;* with your name and email address respectively.

    sudo apt install git
    git clone https://github.com/bubiwahn/rpi-hamclock-web.git
    git config --global pull.ff only
    git config --global user.name '<your name>'
    git config --global user.email '<your email>'

This creates the new directory "~/rpi-hamclock-web" as a git clone of https://github.com/bubiwahn/rpi-hamclock-web.git and set git specific properties.

Inside rpi-hamclock-web project directory you can find the installation and administration command "rpi-hamclock", which you can execute inside project for the remaining steps:

    cd rpi-hamclock-web

- Install/Update (i.e. download an unpack) the latest [ESPHamclock](https://www.clearskyinstitute.com/ham/HamClock/) software release:

        ./rpi-hamclock update

- Build and install hamclock This may take a while, and is the occasion for another coffee break ...

        ./rpi-hamclock install


    


