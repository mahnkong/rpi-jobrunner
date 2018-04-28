# rpi-jobrunner - Cronlike jobrunner based on the ruby lib 'rufus' for executing tasks defined in a yaml config
![Travis build status](https://api.travis-ci.org/mahnkong/rpi-jobrunner.svg?branch=master)

## Yaml - file example
```
---
- name: sz2kindle
  type: cron
  timespec: '30 6 * * *'
  command: /stuff/sz2kindle.sh
- name: certbot
  type: cron
  timespec: '* 5 * * *'
  command: /stuff/certbot_renew.sh
- name: dropbox_push
  type: cron
  timespec: '0 * * * *'
  command: /stuff/rclone_dropbox.sh
```

## Todo
 - support all rufus job types
 - web interface
 - keeb logs per job exec instance
 - on demand exec
