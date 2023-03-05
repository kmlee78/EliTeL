FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --no-install-recommends build-essential curl systemctl sudo -y

ENV WORKDIR=/workspace \
    POETRY_HOME=$HOME/.local \
    POETRY_VERSION=1.3.2 
ENV PATH="$POETRY_HOME/bin:$PATH"
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

# Install Python 3.10
RUN apt-get install zlib1g-dev python3-distutils libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
RUN wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz
RUN tar -xf Python-3.10.9.tgz
RUN ./Python-3.10.9/configure --enable-optimizations
RUN sudo make altinstall
RUN alias python=python3.10

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Install td-agent
RUN apt-get reinstall ca-certificates -y
RUN sudo curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

WORKDIR $WORKDIR
COPY . .
RUN poetry install --sync
RUN chmod +x scripts/*.sh
CMD ["/bin/bash", "scripts/restart_td_agent.sh"]