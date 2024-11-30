
# Ensure all properties are exported as shell env-vars
set export

set dotenv-load

# set the current directory, and the location of the test dats
CWDIR := justfile_directory()

_default:
  @just -f {{justfile()}} --list


# Build the docker image with the runnign users UI
build:
    #!/bin/bash
    set -eo pipefail
 
    rm -rf _weewxdocker | true
    git clone https://github.com/felddy/weewx-docker.git _weewxdocker
    pushd _weewxdocker
    git pull origin pull/345/head:release-5.1
    git checkout release-5.1
    docker build -t tmp_weewxdocker --build-arg WEEWX_UID=$(id -u) -f Dockerfile .
    popd

    docker build -t wombleweewx --build-arg BASE_IMAGE=tmp_weewxdocker -f Dockerfile .

run:
  #!/bin/bash
  set -ex
  
  USB_DEVICE=$(lsusb | awk '/RTL2838/ { print "/dev/bus/usb/" $2 "/" substr($4,0,3) }')
  docker run -it --rm --device $USB_DEVICE -d -v /nfs/weewx/womble1:/data --name weewx wombleweewx 

setup:
  #!/bin/bash
  set -ex
  docker run -it -v /nfs/weewx/womble1:/data  wombleweewx extension install https://github.com/matthewwall/weewx-sdr/archive/master.zip --yes

  # 
# weectl extension install weewx-sdr.zip --config /data/weewx.conf
