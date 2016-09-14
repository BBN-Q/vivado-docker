# vivado-docker

Vivado installed into a docker image for CI purposes.

## Build instructions

1. This docker file assumes your Vivado installer is available on a host a ~/Downloads/Xilinx_Vivado_SDK_2016.1_0409_1.tar.gz
2. Create a password-less ssh rsa key `ssh-keygen -t rsa`
3. Copy resulting private key (`~/.ssh/id_rsa`) into the directory
4. Copy your Vivado `Xilinx.lic` file into the directory.
5. Potentialy modify the `install_config.txt` to change the install options.
6. Build the image (will take about 10 minutes) passing in a build arg
    ```shell
    docker build --build-arg HOST_LOGIN=user@host --rm -t vivado:2016.1 .
    ```

## Running

The `Dockerfile` sets up a `vivado` user to avoid running as root. I have only considered running Vivado in `batch` mode for running CI simulations and building bit files. For development work with the GUI you may have to fiddle with X11 settings.
