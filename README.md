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

#### Create Pi boot image on micro SD card

Start Pi imager on your workstation and to create a suitable boot image for your model on the micro SD card:
1. Select your Raspberry Pi model:</br>
In my case, it is [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/), but you may have different one. You can find an overview of available models on [Raspberry Pi product page](https://www.raspberrypi.com/products/).

2. Select desired Pi OS flavour (depending on step 1).</br>
In opted for Raspberry Pi OS (Legacy, 32 bit), which was the recommended choice for Pi Zero W. It contains a fully functional Linux X Desktop, that makes installation and maintenance very easy.<br/>
(**Note:** This is a trade off. Although it may seem a bit overdosed for the tiny and rather slow Zero, the system performs surpisingly well and satifies the needs for our HamClock application. The response time of user interactions is not overwhelming but it is sufficient for all the installation and maintenance tasks lying ahead. So I decided focus on making it work at first, and then afterwards do some optimization stuff if necessary. This way, I do not have to bother around with unnecessary complexity in the early phase of the project, which keeps me relaxed).


3. Select micro SD card as target for the image. **Be careful, because all existing data is going be destroyed**

4. Open the configuration interface and set some fundamental properties like Pi user and password as well as WLAN name and access password and so on

5. Write image to the flash card.

6. Do the following steps manually on your workstation in the root (i.e.  top-level) directory of the flash card:

    - Create an empty file named "ssh" in the root directory of your micro SD card (this tells PI to accept ssh connections after booting)

    - Append display specific configuration at the end of file "config.txt".<br/>
    (In my case these are the following lines of code. Your's may be different depending on the display model):

            hdmi_group=2
            hdmi_mode=87
            hdmi_cvt 1024 600 60 6 0 0 0
            hdmi_drive=1 

#### Initial Setup of the Pi ("first light")

Eject micro SD card from workstation and insert it into Pi's micro SD slot

Plug in power supply and power up Pi by connecting it with the power cable.

Wait until Pi completed the initial setup routine. This may take a while, I suggest a coffee break ...<br/>
Eventually, you will see the desktop on the screen.

Ping Pi from a workstation console: You should see Pi answering ..<br/>
(if not, then there is probably something wrong with the WLAN configuration properties. In this case, you have to fix it and rewrite the image)

Open a Linux console on your workstation log into Pi with user and password

    ssh user@hamclock

 (if this doesn't work, then there is probably something wrong with the user/password configuration properties. In this case, you have to fix it and rewrite the image)
 
 After ssh connection is etablished, first task is to update and reboot the system:

    sudo apt update
    sudo apt full-upgrade
    sudo shutdown -r now


### Raspberry Pi Configuration

Once the Pi is updated and rebooted, you may want to configure it according your needs. This can be done with a dedicated the configuration tool *raspi-config*. The command

    sudo raspi-config

opens up the interface and allows you to set system parameters interactively. At least, you will want to enable *VNC* in the section *Interface Options*. This allows you to admin Pi via VNC, which might be much more comfortable and intuitive than doing it with plain ssh.

After VNC is available, you can either
- connect via VNC and open an Xterminal on the Pi desktop, or
- continue with ssh.

### Hamclock Web Installation

Installation and adminstration of RPi Hamclock relies on Git. In order to make git available on the Pi, issue the following commands after replacing the placeholders *&lt;your name&gt;* and *&lt;your email&gt;* with your own name and email address respectively.

    sudo apt install git
    git clone https://github.com/bubiwahn/rpi-hamclock-web.git
    git config --global pull.ff only
    git config --global user.name '<your name>'
    git config --global user.email '<your email>'

This creates the new directory "~/rpi-hamclock-web" as a git clone of https://github.com/bubiwahn/rpi-hamclock-web.git and set git specific properties.

Inside rpi-hamclock-web project directory you can find the installation and administration command "rpi-hamclock" which is part of the project. Do the following steps from the rpi-hamclock-web directory:

    cd rpi-hamclock-web

- Install/Update the latest [ESPHamclock](https://www.clearskyinstitute.com/ham/HamClock/) software release:

        ./rpi-hamclock update

- Build and install hamclock on the Pi:

        ./rpi-hamclock install

    (Again, this may take a while, and is the occasion for another coffee break ...)

    


