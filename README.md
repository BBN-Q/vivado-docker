# vivado-docker

Vivado installed into a docker image for CI purposes.

## Build instructions

1. This docker file assumes the Vivado download is available on a webserver somewhere. This can easily be the build machine using the webserver in Python.
    ```shell
    cd /path/to/Vivado/download
    python -m http.server
    ```
2. Copy your Vivado `Xilinx.lic` file into the directory.
3. Potentialy modify the `install_config.txt` to change the install options.
4. Build the image (will take about 10 minutes) passing in a build arg
    ```shell
    docker build --build-arg HOST=HOST_NAME:8000 --rm -t vivado:2016.1 .
    ```

## Running

The `Dockerfile` sets up a `vivado` user to avoid running as root. I have only considered running Vivado in `batch` mode for running CI simulations and building bit files. For development work with the GUI you may have to fiddle with X11 settings.
