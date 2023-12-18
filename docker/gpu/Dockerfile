FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV PYTHONUNBUFFERED=1
ENV SHELL=/bin/bash
ENV TZ=Asia/Tokyo
ENV TF_ENABLE_ONEDNN_OPTS=0
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    # opencv関連
    libgl1-mesa-dev \
    libglib2.0-0 \
    # python build関連
    make \
    wget \
    build-essential libbz2-dev libdb-dev\
    libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev libssl-dev \
    zlib1g-dev uuid-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Python install
ARG PYTHON_VERSION=3.11.7
WORKDIR /tmp/setup
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xJf Python-${PYTHON_VERSION}.tar.xz
WORKDIR /tmp/setup/Python-${PYTHON_VERSION}
RUN ./configure && make && make install

RUN ln -s /usr/local/bin/python3 /usr/local/bin/python 

# Python Library install
COPY ./docker/gpu/requirements.txt .
RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install --no-cache-dir tensorflow[and-cuda] \
    && pip install --no-cache-dir -r requirements.txt

RUN rm -rf /tmp/setup

# UIDとGIDは自分のidと必ず合わせる
# 普通にWSLを使っている際は気にする必要はない
ARG UID=1000
ARG GID=1000

# user作成
RUN groupadd -g ${GID} notebook \
    && useradd -m -s /bin/bash -u ${UID} -g ${GID} notebook

USER notebook
