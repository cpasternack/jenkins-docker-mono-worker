#!/usr/bin/env sh

# set noninteractive installation
export DEBIAN_FRONTEND=noninteractive
#install tzdata package
apt-get update && apt-get install -y --no-install-recommends tzdata
# set your timezone
ln -fs /usr/share/zoneinfo/UTC /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata
export DEBIAN_FRONTEND=interactive

exit 0
