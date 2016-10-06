FROM ubuntu:14.04

MAINTAINER Colm Ryan <cryan@bbn.com>

# build with docker build --build-arg VIVADO_TAR_HOST=host:port -t vivado .

#install dependences for:
# * downloading Vivado (wget)
# * xsim (gcc build-essential to also get make)
# * MIG tool (libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig)
# * CI (git)
RUN apt-get update && apt-get install -y \
  wget \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  git

# copy in config file
COPY install_config.txt /

# download and run the install
ARG VIVADO_TAR_HOST
RUN echo "Downloading Vivado from ${VIVADO_TAR_HOST}" && \
  wget ${VIVADO_TAR_HOST}/Xilinx_Vivado_SDK_2016.1_0409_1.tar.gz -q && \
  echo "Extracting Vivado tar file" && \
  tar xzf Xilinx_Vivado_SDK_2016.1_0409_1.tar.gz && \
  /Xilinx_Vivado_SDK_2016.1_0409_1/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_config.txt && \
  rm -rf Xilinx_Vivado_SDK_2016.1_0409_1*

#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/2016.1/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/
