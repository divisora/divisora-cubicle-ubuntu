FROM docker.io/library/ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# Base packages
RUN apt install --no-install-recommends -y systemd
RUN apt install --no-install-recommends -y lightdm lightdm-gtk-greeter
RUN apt install -y xfce4 xfce4-goodies
RUN apt install --no-install-recommends -y tigervnc-standalone-server
RUN apt-get update
RUN apt install -y freeipa-client

# Remove these packages
## Remove screensavers since it is rendundant and anoying
RUN apt remove -y xfce4-screensaver && apt -y purge xfce4-screensaver
## Remove audio since VNC doesnt support it anyway
RUN apt remove -y pulseaudio && apt -y purge pulseaudio
RUN apt autoremove -y

# Install Firefox
RUN apt install --no-install-recommends -y software-properties-common
RUN add-apt-repository -y ppa:mozillateam/ppa
RUN apt install -y firefox-esr

COPY etc /etc/
COPY opt /opt/

RUN adduser xvnc --gecos "" --shell=/usr/sbin/nologin --no-create-home --disabled-password

RUN chmod 644 /etc/systemd/system/xvnc.socket
RUN chmod 644 /etc/systemd/system/xvnc@.service
RUN chmod 644 /etc/systemd/system/freeipa.service
RUN systemctl enable xvnc.socket
RUN systemctl enable freeipa.service

RUN rm -rf /var/lib/apt/lists/*
RUN apt clean


LABEL se.domain.app-type="user"

CMD [ "/lib/systemd/systemd" ]