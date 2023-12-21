ARG PYTHON_VERSION=3.10.13
FROM python:${PYTHON_VERSION}-slim as builder
ENV PYTHONUNBUFFERED=1

WORKDIR /tmp/setup
COPY ./docker/cpu/requirements.txt .
RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install -r requirements.txt --no-cache-dir

RUN rm -rf /tmp/setup

FROM python:${PYTHON_VERSION}-slim-bullseye
ENV PYTHONUNBUFFERED=1
ENV SHELL=/bin/bash
ENV TZ=Asia/Tokyo
# CPUパフォーマンス最適化
ENV TF_ENABLE_ONEDNN_OPTS=1

RUN apt-get update && apt-get install -y --no-install-recommends\
    libgl1-mesa-dev \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG PYTHON_VERSION=3.10
COPY --from=builder \
    /usr/local/lib/python${PYTHON_VERSION}/site-packages \
    /usr/local/lib/python${PYTHON_VERSION}/site-packages/

# notebookのみ別途入れる
RUN /usr/local/bin/python -m pip install --upgrade pip \
    && pip install notebook --no-cache-dir

# UIDとGIDは自分のidと必ず合わせる
# 普通にWSLを使っている際は気にする必要はない
ARG UID=1000
ARG GID=1000

# user作成
RUN groupadd -g ${GID} notebook \
    && useradd -m -s /bin/bash -u ${UID} -g ${GID} notebook

USER notebook
