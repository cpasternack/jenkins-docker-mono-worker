FROM ubuntu:18.04
MAINTAINER <cpasternack@users.noreply.github.com> 

# Make sure the package repository is up to date.
RUN apt-get -y update 

# Set timezone for debian tzdata with script
# Thanks: https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image/949998
# https://serverfault.com/users/293588/romeo-ninov
ADD ./timezone.sh /timezone.sh
RUN chmod +x /timezone.sh
RUN /timezone.sh

# Install openJDK11 from repo
RUN apt-get install -y default-jdk

# Install git
RUN apt-get install -y git

# Install OpenSSH server
RUN apt-get install -y openssh-server && \
  sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd

# Add Mono from the mono project
# Directions from: https://www.mono-project.com/download/stable/#download-lin
RUN apt install gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt update -y
RUN apt-get update -y

# Install Mono
RUN apt install -y mono-complete
RUN apt-get install -y nuget

# Update nuget
RUN nuget update -self

# Cleanup old packages
RUN apt-get -y autoremove

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
