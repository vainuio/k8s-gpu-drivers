FROM debian:stretch
COPY install.sh /opt/install.sh
RUN chmod +x /opt/install.sh
CMD cp -a /opt/install.sh /rootfs/opt/install.sh && chroot /rootfs/ /opt/install.sh

