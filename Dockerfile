FROM ubuntu:20.04

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install \
    fontconfig-config fonts-dejavu-core libasyncns0 libdrm-intel1 \
    libdrm-nouveau2 libdrm-radeon1 libelf1 libflac8 libfontconfig1 libfreetype6 \
    libgl1-mesa-dri libgl1-mesa-glx libglapi-mesa \
    libgstreamer-plugins-base1.0-0 libgstreamer1.0-0 libice6 \
    libogg0 liborc-0.4-0 libpciaccess0 libpulse0 libsm6 libsndfile1 \
    libvorbis0a libvorbisenc2 libx11-6 libx11-data libx11-xcb1 \
    libxau6 libxcb-dri2-0 libxcb-dri3-0 libxcb-glx0 libxcb-image0 \
    libxcb-present0 libxcb-randr0 libxcb-shape0 libxcb-shm0 libxcb-sync1 \
    libxcb-util1 libxcb-xfixes0 libxcb1 libxcomposite1 libxdamage1 libxdmcp6 \
    libxext6 libxfixes3 libxi6 libxml2 libxrender1 libxshmfence1 libxslt1.1 \
    libxxf86vm1 sgml-base x11-common xml-core curl desktop-file-utils \
    libegl1-mesa libxcb-keysyms1 libxcb-xtest0 libnss3 libxcursor1 libasound2 \
    libxtst6

RUN curl -L https://zoom.us/client/latest/zoom_amd64.deb > /tmp/zoom.deb

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

RUN apt-get -y install \
    ibus
RUN dpkg -i /tmp/zoom.deb && rm /tmp/zoom.deb
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/sudoers.d
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    mkdir -p /home/developer/.config && \
    mkdir -p /home/developer/.zoom && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer

COPY conf/zoomus.conf /home/developer/.config/zoomus.conf
VOLUME ["/home/developer/.zoom"]

ADD ./bin /usr/local/sbin
CMD run
