#!/usr/bin/env bash

######################
#
# Docker build script
#
######################


#docker build --rm --squash --label "version=1.0" --label "maintaner=C Pasternack <cpasternack@noreply.github.com>" -t 192.168.1.250:5000/jenkins_mono_worker:latest -t 192.168.1.250:5000/jenkins_mono_worker:v1.0 .
docker build --rm --label "version=1.0" --label "maintaner=C Pasternack <cpasternack@noreply.github.com>" -t 192.168.1.250:5000/jenkins_mono_worker:latest -t 192.168.1.250:5000/jenkins_mono_worker:v1.0 .
