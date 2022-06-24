FROM ubuntu:focal@sha256:626ffe58f6e7566e00254b638eb7e0f3b11d4da9675088f4781a50ae288f3322

SHELL ["/bin/bash", "-c"]

ENV DISPLAY=:0 \
    TZ=Europe/Berlin
ARG DEBIAN_FRONTEND=noninteractive

# Ubuntu Setup
RUN apt-get update &&\
    apt-get -y --no-install-recommends install \
    ca-certificates \
    git \
    build-essential \
    netbase \
    zip \
    unzip \
    xclip \
    zsh \
    gnupg2 \
    nano \
    ssh-client \
    locales &&\
    locale-gen en_US.UTF-8 &&\
    locale-gen de_DE.UTF-8 &&\
    update-locale LANG=en_US.UTF-8

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8

# Install R
ENV R_VERSION=4.2.0

# Set RSPM snapshot see:
# https://packagemanager.rstudio.com/client/#/repos/1/overview
ENV R_REPOS=https://packagemanager.rstudio.com/all/__linux__/focal/2022-05-13+Y3JhbiwyOjQ1MjYyMTU7MTM4M0EyQ0M

COPY install_r.sh /install_scripts/install_r.sh
COPY r_packages.txt /package_lists/r_packages.txt
COPY r_packages_github.txt /package_lists/r_packages_github.txt

RUN chmod +x install_scripts/install_r.sh &&\
    install_scripts/install_r.sh

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install ./google-chrome-stable_current_amd64.deb --yes \
    && rm ./google-chrome-stable_current_amd64.deb

# Set the default shell to zsh rather than bash
RUN mkdir -p "$HOME/.zsh" &&\
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

COPY .misc/.zshrc /root/.
COPY .misc/.Rprofile /root/.

COPY .misc/.zshrc /root/.
COPY .misc/.Rprofile /root/.

# Set the default shell to zsh rather than bash
ENTRYPOINT [ "/bin/zsh" ]