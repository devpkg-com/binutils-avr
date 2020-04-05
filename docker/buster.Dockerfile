FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

COPY apt.conf /etc/apt/apt.conf.d/install

RUN apt-get update
RUN apt-get install -y ca-certificates

RUN echo 'LC_ALL=en_US.UTF-8' >> /etc/environment
RUN echo "localepurge localepurge/nopurge multiselect en,en_US.UTF-8" | debconf-set-selections
RUN apt-get install -y localepurge
RUN dpkg-reconfigure localepurge
RUN localepurge

RUN apt-get install -y gnupg2 wget localepurge
RUN wget -O - https://devpkg.com/DF0152B9BE52614853BDDD22612844377396A186.asc | apt-key add -
COPY sources.list /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -y texinfo
RUN apt-get install -y gcc-avr
RUN apt-get install -y binutils
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y tar
RUN apt-get install -y build-essential
RUN apt-get install -y debhelper
RUN apt-get install -y wget

RUN apt-get purge -y gnupg2
RUN apt-get -y autoremove
RUN rm -fr /usr/share/locale/*
RUN rm -fr /usr/share/doc/*
RUN rm -fr /usr/share/i18n/*
RUN rm -fr /var/lib/apt/lists/*.lz4
