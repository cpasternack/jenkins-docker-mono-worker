#!/usr/bin/env bash

######################
#
# Docker build script
#
######################


#docker build --rm --squash --label "version=1.0" --label "maintaner=C Pasternack <cpasternack@noreply.github.com>" -t cpasternack/jenkins_mono_worker:latest -t cpasternack/jenkins_mono_worker:v1.0 .
docker build --rm --label "version=1.0" --label "maintaner=C Pasternack <cpasternack@noreply.github.com>" -t cpasternack/jenkins_mono_worker:latest -t cpasternack/jenkins_mono_worker:v1.0 .
