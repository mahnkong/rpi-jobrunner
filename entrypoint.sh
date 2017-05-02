#!/bin/bash
if [ "$TZ" != "" ]; then
    cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
fi
exec jobrunner "$*"
