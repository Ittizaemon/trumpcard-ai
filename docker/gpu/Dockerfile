ARG PYTHON_VERSION=3.10.13
FROM python:${PYTHON_VERSION}-slim as builder
ENV PYTHONUNBUFFERED=1

WORKDIR /tmp/setup
COPY ./docker/gpu/requirements.txt .
RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install -r requirements.txt --no-cache-dir

RUN rm -rf /tmp/setup

FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

ENV PYTHONUNBUFFERED=1
ENV SHELL=/bin/bash
ENV TZ=Asia/Tokyo

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    # opencv関連
    libgl1-mesa-dev \
    libglib2.0-0 \
    # numa関連(numa.h)
    libnuma-dev \
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
ARG PYTHON_VERSION=3.10.13
WORKDIR /tmp/setup
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xJf Python-${PYTHON_VERSION}.tar.xz
WORKDIR /tmp/setup/Python-${PYTHON_VERSION}
RUN ./configure && make && make install

RUN ln -s /usr/local/bin/python3 /usr/local/bin/python 

ARG PYTHON_VERSION=3.10
COPY --from=builder \
    /usr/local/lib/python${PYTHON_VERSION}/site-packages \
    /usr/local/lib/python${PYTHON_VERSION}/site-packages/

# Python Library install
COPY ./docker/gpu/requirements.txt .
RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install --no-cache-dir tensorflow[and-cuda] notebook tensorrt numa

RUN rm -rf /tmp/setup

# UIDとGIDは自分のidと必ず合わせる
# 普通にWSLを使っている際は気にする必要はない
ARG UID=1000
ARG GID=1000

# user作成
RUN groupadd -g ${GID} notebook \
    && useradd -m -s /bin/bash -u ${UID} -g ${GID} notebook

USER notebook
