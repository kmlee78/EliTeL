FROM python:3.10-slim as base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --no-install-recommends build-essential curl systemctl sudo -y

ENV PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=$PYTHONPATH:. \
    POETRY_VIRTUALENVS_IN_PROJECT=false \
    POETRY_VIRTUALENVS_CREATE=false \
    POETRY_NO_INTERACTION=1 \
    POETRY_HOME=$HOME/.poetry \
    POETRY_VERSION=1.3.2 \
    WORKDIR=/workspace
# FLUENT_PID="$WORKDIR/log/td-agent.pid" \
# FLUENT_SOCKET="$WORKDIR/log/td-agent.sock" \
# FLUENT_PLUGIN_DIR="$WORKDIR/plugins" \
# FLUENT_PLUGIN_CONF_DIR="$WORKDIR/config/plugins" \
# FLUENT_PLUGIN_CONF="$WORKDIR/config/plugins/td-agent.conf" \
# FLUENT_PLUGIN_CONF_BACKUP="$WORKDIR/config/plugins/td-agent.conf.bak" \
# FLUENT_PLUGIN_CONF_BACKUP2="$WORKDIR/config/plugins/td-agent.conf.bak2" \
# FLUENT_PLUGIN_CONF_BACKUP3="$WORKDIR/config/plugins/td-agent.conf.bak3" \
# FLUENT_PLUGIN_CONF_BACKUP4="$WORKDIR/config/plugins/td-agent.conf.bak4" \
# FLUENT_PLUGIN_CONF_BACKUP5="$WORKDIR/config/plugins/td-agent.conf.bak5" \
# FLUENT_PLUGIN_CONF_BACKUP6="$WORKDIR/config/plugins/td-agent.conf.bak6"
ENV PATH="$POETRY_HOME/bin:$PATH" 
WORKDIR $WORKDIR

RUN curl -sSL https://install.python-poetry.org | python3 -
COPY ./poetry.lock ./pyproject.toml ./
RUN poetry install --sync 

RUN curl -fsSL https://toolbelt.treasuredata.com/sh/install-debian-bullseye-td-agent4.sh | sh
COPY . .
RUN chmod +x scripts/*.sh
CMD ["/bin/bash", "scripts/start_td_agent.sh"]