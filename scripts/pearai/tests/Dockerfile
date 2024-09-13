FROM python:3.11-bullseye

# Set working directory
WORKDIR /workspace

# Set environment variable for current branch
ARG CURRENT_BRANCH
ENV CURRENT_BRANCH=${CURRENT_BRANCH}

# Update and install basic tools
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    apt-get install -y \
    curl \
    git \
    build-essential \
    wget \
    software-properties-common \
    libkrb5-dev \
    pkg-config \
    libx11-dev \
    libxkbfile-dev \
    libffi-dev \
    libbz2-dev \
    libncurses5-dev \
    libgdbm-dev \
    liblzma-dev \
    libssl-dev \
    libreadline-dev \
    libsqlite3-dev \
    tk-dev \
    uuid-dev \
    libnss3-dev

RUN useradd -m -s /bin/bash developer


RUN apt-get install -y sudo && \
    echo "developer ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/developer

RUN chown -R developer:developer /usr/local/bin
RUN chown developer:developer /workspace && \
    chmod 755 /workspace


USER developer


RUN echo "export PATH=\$PATH:/usr/bin" >> /home/developer/.bashrc


CMD ["/bin/bash"]
