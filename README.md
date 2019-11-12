# jenkins-docker-mono-worker

Builds an Ubuntu 18.04 image with openSSH server to support jenkins msbuild work.

## Updates:
- 11/2019: Removed openjdk8-jre/jdk via PPA. Now installs openjdk11 (default-jdk).
- 11/2019: Two Dockerfiles: openjdk8, openjdk11. Dockerfile is openjdk11

## Notes:
This is not a very optimised dockerfile or image yet. I have been testing this out with jenkins versions matching the openjdk versions in the dockerfile.
This builds mono 6, with pre-compile using llvm.

## TODO:
- 11/2019: Add Jenkinsfile for local building and tagging
