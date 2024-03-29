# == Info =======================================
# ubuntu22.04(SIZE: 77.8MB) -> hibuz/bash(SIZE: 279MB)

# == Build ======================================
# docker build -t hibuz/bash .
# or
# docker build -t hibuz/bash --build-arg DEFAULT_USER=ubuntu --build-arg UBUNTU_VERSION=2x.04 .

# == Run temporary ==============================
# docker run --rm -it hibuz/bash


# == Init =======================================
ARG UBUNTU_VERSION=${UBUNTU_VERSION:-latest}
FROM ubuntu:${UBUNTU_VERSION}
LABEL org.opencontainers.image.authors="hibuz@hibuz.com"

# == Locale Setting =============================
RUN sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
  tzdata \
  locales \
  && locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

# == Package Setting ============================
RUN apt-get update && apt-get install -y \
  sudo \
  iputils-ping \
  net-tools \
  curl \
  vim \
  git \
  && rm -rf /var/lib/apt/lists/*

# == User Setting ===============================
ARG DEFAULT_USER=${DEFAULT_USER:-ubuntu}
ENV DEFAULT_USER ${DEFAULT_USER}
RUN groupadd -g 1000 ${DEFAULT_USER} \
  && useradd -r -u 1000 -g ${DEFAULT_USER} -s /bin/bash ${DEFAULT_USER} \
  && mkdir /home/${DEFAULT_USER} \
  && chown -R ${DEFAULT_USER}:${DEFAULT_USER} /home/${DEFAULT_USER} \
  && echo "$DEFAULT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

ENTRYPOINT ["/bin/bash"]