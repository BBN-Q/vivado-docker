FROM ubuntu:14.04

MAINTAINER Colm Ryan <cryan@bbn.com>

#install dependences for:
# * xsim (gcc build-essential to also get make)
# * MIG tool (libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig)
# * CI (git)
RUN apt-get update && apt-get install -y \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  git

#Copy in Vivado installer and config file
# TODO: is there any way to save image size here?
ADD Xilinx_Vivado_SDK_2015.3_0929_1.tar.gz /
COPY install_config.txt /Xilinx_Vivado_SDK_2015.3_0929_1/

#run the install
RUN /Xilinx_Vivado_SDK_2015.3_0929_1/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config /Xilinx_Vivado_SDK_2015.3_0929_1/install_config.txt

#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/2015.3/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/
