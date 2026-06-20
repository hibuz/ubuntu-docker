# == Info =======================================
# hibuz/bash(SIZE: 482MB) -> hibuz/zsh(SIZE: 541MB)

# == Build ======================================
# docker build -t hibuz/zsh -f Dockerfile.zsh .
# or
# docker build -t hibuz/zsh -f Dockerfile.zsh  --build-arg BASE_IMAGE=bash --build-arg UBUNTU_VERSION=2x.04 .

# == Run temporary ==============================
# docker run --rm -it hibuz/zsh


# == Init =======================================
ARG UBUNTU_VERSION=26.04
FROM hibuz/bash:${UBUNTU_VERSION}

USER ubuntu
WORKDIR /home/ubuntu

# == Package Setting ============================
RUN sudo apt update \
  && sudo apt install -y \
  wget \
  zsh \
  && sudo rm -rf /var/lib/apt/lists/*

# == Oh My Zsh Setting ================================
RUN sudo chsh -s /bin/zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

RUN perl -pi -w -e 's/ZSH_THEME=.*/ZSH_THEME="agnoster"/g;' ~/.zshrc
RUN perl -pi -w -e 's/plugins=.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g;' ~/.zshrc

ENTRYPOINT ["/usr/bin/zsh"]