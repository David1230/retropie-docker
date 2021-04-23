FROM navikey/raspbian-buster
#FROM resin/rpi-raspbian
RUN  apt-get update \
    &&  apt-get upgrade -y \
    &&  apt-get install -y --no-install-recommends \
    ca-certificates git lsb-release sudo subversion \
    dialog gcc g++ build-essential unzip xmlstarlet \
    python3-pyudev usbutils joystick \
    &&  useradd -d /home/pi -G sudo -m pi \
    &&  echo "pi ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/pi

WORKDIR /home/pi

USER pi

RUN git clone --depth=1 https://github.com/RetroPie/RetroPie-Setup.git --branch 4.6 \
    && cd RetroPie-Setup \
    && sudo chmod +x retropie_setup.sh \
    && sudo ./retropie_packages.sh setup basic_install \
    && sudo rm -rf /var/lib/apt/lists/* \
    && sudo chown -R pi /home/pi/RetroPie

VOLUME /home/pi/RetroPie

#ENTRYPOINT "/bin/bash"
RUN sudo usermod -aG adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input pi

ENTRYPOINT "/usr/bin/emulationstation"

CMD "#auto"
