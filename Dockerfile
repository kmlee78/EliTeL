FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install --no-install-recommends build-essential curl systemctl -y
RUN apt-get install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget libbz2-dev -y
RUN wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz
RUN tar -xf Python-3.10.*.tgz
RUN cd Python-3.10.* && ./configure --enable-optimizations
ENV WORKDIR=/workspace 
ENV FLUENT_CONF="$WORKDIR/config/td-agent.conf" \
    FLUENT_LOG="$WORKDIR/log/td-agent.log" 
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
RUN apt-get reinstall ca-certificates -y
RUN curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh

WORKDIR $WORKDIR
COPY . .