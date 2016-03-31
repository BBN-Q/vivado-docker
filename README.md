# vivado-docker

Vivado installed into a docker image for CI purposes.

## Build instructions

1. Copy the Vivado installer (Xilinx_Vivado_SDK_2015.3_0929_1.tar.gz) file into the directory.
1. Copy your Vivado `Xilinx.lic` file into the directory.
2. Potentialy modify the `install_config.txt` to change the install options.
3. Build the image (will take about 10 minutes)
    ```shell
    docker build -t caryan/vivado:2015.3 .
    ```

## Running

The `Dockerfile` sets up a `vivado` user to avoid running as root. I have only considered running Vivado in `batch` mode for running CI simulations and building bit files. For development work with the GUI you may have to fiddle with X11 settings.
