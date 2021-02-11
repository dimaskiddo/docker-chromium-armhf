FROM docker.io/arm32v7/ubuntu:bionic
MAINTAINER Dimas Restu Hidayanto <dimas.restu@student.upi.edu>

# Setting-up Environment
ENV LANG=en_US.UTF-8\
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    DEBIAN_FRONTEND=noninteractive \
    HOME=/home/user

# Change Working User to "Root"
USER root

# Change Working Directory to "Root" Home Directory
WORKDIR /root

# Setting-up Locale
RUN mv /bin/sh /bin/sh.orig~ \
  && ln -sf /bin/bash /bin/sh \
  && apt-get -y -o Acquire::Check-Valid-Until=false update \
  && apt-get -y -o Acquire::Check-Valid-Until=false --no-install-recommends install \
      locales \
  && apt-get -y -o Acquire::Check-Valid-Until=false purge --autoremove \
  && apt-get -y -o Acquire::Check-Valid-Until=false clean \      
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && locale-gen

# Copying Prequisites Configuration
COPY ./content/ /usr/local/docker/

# Setting-up Permissions  
RUN chmod 775 /usr/local/docker/bin/build \
  && /usr/local/docker/bin/build \
  && rm -f /usr/local/docker/bin/build

# Set Executor Script
CMD ["chromium-browser", "--disable-features=RendererCodeIntegrity", "--user-agent='Mozilla/5.0 (X11; CrOS armv7l 12607.82.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.129 Safari/537.36'"]

# Change Working User to "User"
USER user

# Set Labels Used in OpenShift to Describe the Builder Images
LABEL release=1 \
      vendor="Ubuntu" \
      maintainer="Dimas Restu Hidayanto <dimas.restu@student.upi.edu>"
