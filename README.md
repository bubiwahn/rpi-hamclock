# Web based Rasperry Pi Hamclock with HDMI Touch Display

## Disclaimer
This is open source. The content (information and software) is provided "as is". There is no guarantee that things work as described or expected. You will encounter differences and difficulties and may damage things.
You are fully responsible and liable for anything that you do with this information and/or software.</br>
If you find any bugs, or devise any improvements, please drop a pull request or get otherwise in contact on Github. Let's see what we can do together.

## Prerequisites

### Tools and Dev Environment
- A wireless LAN with internet connectivity
- Any kind of Linux box as workstation for the installation and administration process.<br/>
  (Linux is available on other major computing platforms e.g. Windows, Mac, Chromebook, etc., use anything you like)

### Hardware
- Any Rasperry Pi with WLAN connectivity, HDMI display port and USB data/power port.<br/>
(e.g. [Raspberry Pi Zero W](https://www.raspberrypi.com/products/raspberry-pi-zero-w/), but you may have a different one. You can find an overview of available models on [Raspberry Pi product page](https://www.raspberrypi.com/products/)).
- HDMI touch screen with USB data/power port (e.g. [WAVESHARE 7inch HDMI LCD (C)](https://www.waveshare.com/wiki/7inch_HDMI_LCD_(C)))
- HDMI diplay connector (HDMI male to mini HDMI male)
- USB data/power connector (micro USB male to micro USB male. It must have "on-the-go" wiring otherwise the touch function will not work)
- USB power supply according to your hardware configuration (e.g. 5V, 2A for the given setup)
- USB power cable (USB male to micro USB male)
- any micro sd card that works well with your raspberry model

### Software
- [rpi-hamclock-web](https://github.com/bubiwahn/rpi-hamclock-web) (this project)
- [Raspberry Pi OS](https://www.raspberrypi.com/software/)
- optional, VNC client software (e.g. [Real VNC](https://www.realvnc.com/en/connect/download/viewer/))
- dependency, [ESPHamclock](https://www.clearskyinstitute.com/ham/HamClock/) (i.e. the well-known Hamclock project)<
  (you don't have to install it by yourself, it's handled as an automatic dependency)

## Step by Step Setup

### Hardware Setup
We won't go into detail here, but roughly have to do the following:

- Assemble the display
- Mount Pi piggyback on display's backside
- Connect the display and Pi with the connection cables mentioned above

### Raspberry Pi headless setup

#### Create Pi boot image on micro SD card

Start Pi imager on your workstation and create a suitable boot image for your model on the micro SD card:
1. Select Raspberry Pi model from the list

2. Select desired Pi OS flavour (depending on step 1).</br>
For Pi Zero W this should be Raspberry Pi OS (Legacy, 32 bit, "Bullseye"), which is recommended by the imager. It includes a fully functional Linux X desktop that makes installation and maintenance very easy.<br/>
(**Note:** This seem a bit strange for the tiny and rather slow Zero, but the system works surprisingly well and meets the needs of our HamClock application. The response time of user interactions is not overwhelming, enough but for any upcoming installation and maintenance tasks. Try to focus on making it work first and make some tweaks later if necessary. This way you don't have to deal with unnecessary complexity in the early stages of your project.)

3. Select micro SD card as target for the image. **Be careful, because all existing data is going be destroyed**

4. Open the configuration view and set initial properties:
    - hostname (must be unique within network),
    - Pi username an password (write it down, you need this information later to log in)
    - WIFI name, password and the specific option country option for your location
    - Timezone and keyboard layout

5. Write to flash card.

6. Do the following steps manually on your workstation in the root (i.e. top-level) directory of the flash card:

    - Create an empty file named "ssh" in the root directory of your micro SD card (this tells PI to accept ssh connections after booting)

    - Append display specific configuration at the end of file "config.txt".<br/>
    (For the above mentioned Waveshare diplay, these are the following lines of code. **Beware! Your display settings may be different depending on the display model, DO YOUR OWN RESEARCH**):

            hdmi_group=2
            hdmi_mode=87
            hdmi_cvt 1024 600 60 6 0 0 0
            hdmi_drive=1 

#### First Light - Initial Setup of the Pi

Eject micro SD card from workstation and insert it into Pi's micro SD slot

Plug in power supply and power up Pi.

Wait for Pi to complete the initial setup routine. This may take a while, I suggest a coffee break...<br/>
Finally you will see the desktop on the screen.

Ping Pi from a workstation console: You should see Pi respond...<br/>
(If not, there is probably something wrong with the Wi-Fi configuration properties. In this case, you will need to fix the problem and rewrite the image.)

    ping <Pi-hostname>               # replace <Pi-hostname> with your settings.

Open a Linux console on your workstation and log in into Pi with user and password

    ssh <Pi-user>@<Pi-hostname>      # replace <Pi-user> and <Pi-hostname> with your settings.

 (If this doesn't work, then there is probably something wrong with the user/password configuration properties. In this case, you will need to fix the problem and rewrite the image.)
 
 After ssh connection is etablished, first your task is to update and reboot the system:

    sudo apt update
    sudo apt full-upgrade
    sudo shutdown -r now


### Raspberry Pi Configuration

Once the Pi is updated and rebooted, and you are logged in again, you may want to tweak it according your needs. This can be done with a dedicated the configuration tool *raspi-config*. The command

    sudo raspi-config

opens the tool and enables the interactive setting of system parameters. At least you should enable *VNC* in the *Interface Options* section. This allows you to manage Pi via VNC, which may be much more convenient and intuitive than using simple SSH.

When VNC is available, you can either
- connect via VNC and open an Xterminal on the Pi desktop, or
- continue with ssh.

### Hamclock Web Installation

Installation and adminstration of RPi Hamclock relies on Git. If Git isn't installed yet, you can issue the following commands in order to make git available. In this case, don't forget to replace the placeholders *&lt;your name&gt;* and *&lt;your email&gt;* on the "git -config .." lines with your own name and email address respectively. Or you can do use any Git configuration that you personally prefer.

    sudo apt install git
    git clone https://github.com/bubiwahn/rpi-hamclock-web.git
    git config --global pull.ff only                 # optional
    git config --global user.name '<your name>'      # optional, replace our '<your name>' with your name
    git config --global user.email '<your email>'    # optional, replace our '<your email>' with your email address

This creates the new directory "~/rpi-hamclock-web" as a git clone of https://github.com/bubiwahn/rpi-hamclock-web.git and set git specific properties.

Inside rpi-hamclock-web project directory you can find the installation and administration command "rpi-hamclock" which is part of the project. Do the following steps from the rpi-hamclock-web directory:

    cd rpi-hamclock-web

#### Update the to latest [ESPHamclock](https://www.clearskyinstitute.com/ham/HamClock/) software release

    ./rpi-hamclock update

(Again, this is a heavy task and may take a while. Occasion for another coffee break ...)

#### Install the hamclock software on the machine

    ./rpi-hamclock install -d -a

    
This operation makes the following changes:
1. copy the hamclock excutable to ``/usr/local/bin/hamclock``, thus making it available as a Linux command
2. Create a ``.desktop`` file at ``~/Desktop/hamclock.desktop``, which allows you to start the application manually by double click. (Option ``-d``)
3. Create a symbolic ``~/.config/autotart/hamclock.desktop --> ~/Desktop/hamclock.desktop`` in order start the application automatically after reboot.

#### Verify your setup
- Double-click the HamClock desktop icon. After a while, HamClock should appear on the screen.<br/>

- In order to close (i.e. stop) the application, you can issue the following command
      
        rpi-hamclock stop  


    There are two methods to do this:
    
    1. **In a VNC session:** Toggle fullscreen mode by typing ``F11``. After that, the Desktop should become visible and you can open a Terminal and enter the command.
    
    1. **In an SSH session:**: Just enter it.
    
- Reboot the system with ``sudo shutdown -r now``. After reboot, HamClock should appear on the screen.
    
If everything is fine, congratulations, you accomplished the basic setup of RPi Hamclock.


    


