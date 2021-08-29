# == Info =======================================
# ubuntu20.04(SIZE: 72.7MB) -> hibuz/bvzsh-master(SIZE: 679MB), hibuz/bvzsh-powertools(SIZE: 705MB)
# Reference: https://github.com/black7375/BlaCk-Void-Zsh/tree/master/Docker

# == Build & Run (master) =======================
# docker build -t hibuz/bvzsh .
# docker run --rm -it hibuz/bvzsh

# == Build & Run (powertools) ===================
# docker build -t hibuz/bvzsh-powertools --build-arg DEFAULT_USER=ubuntu --build-arg BRANCH=powertools --build-arg UBUNTU_IMAGE_TAG=20.04 .
# docker run --rm -it hibuz/bvzsh-powertools


# == Init =======================================
ARG UBUNTU_IMAGE_TAG=latest
FROM ubuntu:${UBUNTU_IMAGE_TAG}
LABEL org.opencontainers.image.authors="hibuz@hibuz.com"

# == Locale Setting =============================
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
  lsb-release \
  inetutils-tools \
  unzip \
  && rm -rf /var/lib/apt/lists/*

# == User Setting ===============================
ARG DEFAULT_USER=ubuntu
RUN groupadd -g 1000 ${DEFAULT_USER} \
  && useradd -r -u 1000 -g ${DEFAULT_USER} -s /bin/bash ${DEFAULT_USER} \
  && mkdir /home/${DEFAULT_USER} \
  && chown -R ${DEFAULT_USER}:${DEFAULT_USER} /home/${DEFAULT_USER} \
  && echo "$DEFAULT_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${DEFAULT_USER}
WORKDIR /home/${DEFAULT_USER}

# == Zsh Setting ================================
SHELL ["/bin/bash", "-c"]
ENV NO_FONT YES
ENV NO_DEFAULT YES
ARG BRANCH=master
RUN git clone -b ${BRANCH} https://github.com/black7375/BlaCk-Void-Zsh.git ~/.zsh
RUN ~/.zsh/BlaCk-Void-Zsh.sh

# https://github.com/zdharma/zinit/issues/484
ARG TERM
ENV TERM ${TERM:-xterm}
RUN SHELL=/bin/zsh zsh -isc -- "zinit module build; @zinit-scheduler burst || true"
RUN zsh -isc "source ~/.zsh/lib/lazyenv.zsh && zinit for light-mode id-as"_local/lazyenv" eval"${LAZYENV_COMMANDS}" zdharma/null"

ENTRYPOINT ["/usr/bin/zsh"]