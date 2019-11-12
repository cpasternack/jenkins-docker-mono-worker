FROM ubuntu:18.04
MAINTAINER <cpasternack@users.noreply.github.com> 

# Set timezone for debian tzdata with script
# Thanks: https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image/949998
# https://serverfault.com/users/293588/romeo-ninov
ADD ./timezone.sh /timezone.sh
RUN chmod +x /timezone.sh && \
/timezone.sh

# Install openJDK11 from repo
RUN apt-get install -y --no-install-recommends \
  openjdk-8-jdk-headless \
  openjdk-8-jre-headless

# Install curl and git
RUN apt-get install -y --no-install-recommends \
  curl \
  git \
  gnupg

# Install OpenSSH server
RUN apt-get install -y --no-install-recommends \
  openssh-server && \
  sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd

# Add Mono from the mono project
# Directions from: https://www.mono-project.com/download/stable/#download-lin
# 11/2019: key not found in hkp://keyserver.ubuntu.com:80
# https://github.com/mono/mono/issues/9891
RUN curl https://download.mono-project.com/repo/xamarin.gpg | apt-key add - && \
  echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
  apt update -y && \
  apt-get update -y

# Install Mono and nuget
RUN apt install -y --no-install-recommends \
  mono-complete \
  nuget

# Update nuget
RUN nuget update -self

# Cleanup old packages
RUN apt-get -y autoremove && \
apt-get -y clean && \
rm -rf /var/lib/apt/lists/*

# Add user jenkins to the image
RUN adduser --quiet jenkins &&\
# Set password for the jenkins user (chpasswd format username:cleartext_pw)
  echo "jenkins:jenkins" | chpasswd
   
# Copy settings
#ADD settings.xml /home/jenkins/
# Copy authorized keys
ADD ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

# Set that .ssh
RUN chown -R jenkins:jenkins /home/jenkins/.ssh/

# Standard SSH port
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
