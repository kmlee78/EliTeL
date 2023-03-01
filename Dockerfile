FROM python:3.10-slim
RUN apt-get update && apt-get install --no-install-recommends -y build-essential curl sudo systemctl
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone
ENV PYTHONHASHSEED=random \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    POETRY_HOME=$HOME/.poetry \
    POETRY_VIRTUALENVS_CREATE=false \
    WORKDIR=/workspace \
    POETRY_VERSION=1.3.2 
ENV PATH="$POETRY_HOME/bin:$PATH" 
RUN curl -sSL https://install.python-poetry.org | python3 -
RUN apt-get reinstall ca-certificates
RUN sudo curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

WORKDIR $WORKDIR
COPY . .
RUN poetry install --sync