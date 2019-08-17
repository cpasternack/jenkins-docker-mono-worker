FROM ubuntu:18.04
MAINTAINER <cpasternack@noreply.github.com> 

# Make sure the package repository is up to date.
RUN apt-get -y update 

# Set timezone for debian tzdata with script
# Thanks: https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image/949998
# https://serverfault.com/users/293588/romeo-ninov
ADD ./timezone.sh /timezone.sh
RUN chmod +x /timezone.sh
RUN /timezone.sh

# Add PPA
RUN apt install software-properties-common apt-transport-https -y

# Add openJDK-r ppa repo
RUN add-apt-repository ppa:openjdk-r/ppa -y

# Install openJDK from PPA
RUN apt install openjdk-8-jdk openjdk-8-jre -y

# Install git
RUN apt-get install -y git

# Install OpenSSH server
RUN apt-get install -y openssh-server && \
  sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
  mkdir -p /var/run/sshd

# Install Mono
RUN  apt-get install -y mono-complete nuget

# Update nuget
RUN nuget update -self

# Cleanup old packages
RUN  apt-get -y autoremove

# Add user jenkins to the image
RUN  adduser --quiet jenkins &&\
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
