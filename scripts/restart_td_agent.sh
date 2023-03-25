#!/bin/bash

set -ex

source_file="/workspace/config/td-agent.conf"
destination_file="/etc/td-agent/td-agent.conf"
cat $source_file > $destination_file

systemctl start td-agent.service