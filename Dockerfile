FROM ubuntu:14.04

MAINTAINER Colm Ryan <cryan@bbn.com>

# build with docker build --build-arg HOST_LOGIN=user@host --rm -t vivado .


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

#Copy in config file and ssh private key
COPY install_config.txt /
COPY id_rsa /

#run the install
ARG HOST_LOGIN
RUN ssh -oStrictHostKeyChecking=no ${HOST_LOGIN} -i id_rsa "cat ~/Downloads/Xilinx_Vivado_SDK_2016.1_0409_1.tar.gz -" | tar xzv && \
  /Xilinx_Vivado_SDK_2016.1_0409_1/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_config.txt && \
  rm -rf Xilinx_Vivado_SDK_2016.1_0409_1 && \
  rm id_rsa && \
  rm /root/.ssh/known_hosts

#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/2016.1/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/
