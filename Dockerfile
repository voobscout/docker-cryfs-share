FROM debian:jessie-backports
MAINTAINER Voob of Doom <voobscout@gmail.com>

ADD https://www.cryfs.org/install.sh /opt/bin/cryfs_install.sh

RUN export DEBIAN_FRONTEND='noninteractive' && \
    export GIT_SSL_NO_VERIFY=1 && \
    export container=docker && \
    apt-get -qq update && \
    apt-get -qqy dist-upgrade && \
    apt-get install -qqy \
    nfs-kernel-server samba inotify-tools wget sudo lsb-release && \
    useradd smbuser -M && \
    chmod 0755 /opt/bin/cryfs_install.sh && \
    rm -rf /var/lib/apt/lists/* \
    /tmp/* \
    /var/log/apt/* \
    /var/log/alternatives.log \
    /var/log/bootstrap.log \
    /var/log/dpkg.log

RUN /opt/bin/cryfs_install.sh
RUN rm -rf /opt/bin/cryfs_install.sh

COPY entrypoint.sh /
COPY smb.conf /etc/samba/smb.conf
COPY exports /etc/exports

EXPOSE 111/udp 2049/tcp 139 445
ENTRYPOINT /entrypoint.sh
