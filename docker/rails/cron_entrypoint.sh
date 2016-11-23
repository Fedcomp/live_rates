#!/bin/bash
whenever --update-crontab
crontab -l
exec cron -f -L 15
