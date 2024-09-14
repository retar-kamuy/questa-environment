FROM rockylinux:8
ENV container=docker
WORKDIR /root/
COPY .docker/ModelSimSetup-20.1.1.720-linux.run /root/
RUN dnf -y install glibc.i686 ncurses-libs.i686 libstdc++.i686 \
    && dnf -y install zlib.i686 bzip2 bzip2-libs.i686 \
    && dnf -y install libXext.i686 libXft.i686 \
    && dnf -y install git \
    && dnf clean all \
    && ./ModelSimSetup-20.1.1.720-linux.run \
    --mode unattended \
    --unattendedmodeui minimal \
    --installdir /opt/intelFPGA/20.1 \
    --modelsim_edition modelsim_ase \
    --accept_eula 1 \
    && rm -f ./ModelSimSetup-20.1.1.720-linux.run
ENV MTI_PATH=/opt/intelFPGA/20.1/modelsim_ase
