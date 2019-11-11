#!/usr/bin/env bash

######################
#
# Docker build script
#
######################


#docker build --rm --squash --label "version=openjdk8" --label "maintaner=C Pasternack <cpasternack@users.noreply.github.com>" -t cpasternack/jenkins_mono_worker:lts -t cpasternack/jenkins_mono_worker:openjdk8 .
docker build --rm --label "version=openjdk11" --label "maintaner=C Pasternack <cpasternack@users.noreply.github.com>" -t cpasternack/jenkins_mono_worker:latest -t cpasternack/jenkins_mono_worker:openjdk11 .
