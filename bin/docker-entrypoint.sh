#!/bin/bash
set -x

USER=lili

chown -R ${USER} .
cron && exec gosu ${USER} "$@"
