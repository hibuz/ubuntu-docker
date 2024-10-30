# == Info =======================================
# ubuntu24.04(SIZE: 78.1MB) -> hibuz/bash(SIZE: 262MB)

# == Build ======================================
# docker build -t hibuz/bash .
# or
# docker build -t hibuz/bash --build-arg DEFAULT_USER=hibuz --build-arg UBUNTU_VERSION=2x.04 .

# == Run temporary ==============================
# docker run --rm -it hibuz/bash


# == Init =======================================
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}
LABEL org.opencontainers.image.authors="hibuz@hibuz.com"

# == Package Setting ============================
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN sed -i 's/archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list.d/ubuntu.sources \
  && DEBIAN_FRONTEND=noninteractive apt update \
  && apt install -y \
  locales \
  language-pack-en \
  sudo \
  tini \
  iputils-ping \
  net-tools \
  curl \
  vim \
  git \
  && rm -rf /var/lib/apt/lists/* \
  && apt autoclean \
  && apt clean

# == User Setting ===============================
ARG DEFAULT_USER=hibuz
ENV DEFAULT_USER ${DEFAULT_USER}
RUN groupadd -g 1001 ${DEFAULT_USER} \
  && useradd -r -u 1001 -g ${DEFAULT_USER} -s /bin/bash ${DEFAULT_USER} \
  && mkdir /home/${DEFAULT_USER} \
  && chown -R ${DEFAULT_USER}:${DEFAULT_USER} /home/${DEFAULT_USER} \
  && echo "$DEFAULT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

ENTRYPOINT ["/bin/bash"]