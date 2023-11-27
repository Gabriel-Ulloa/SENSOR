#!/bin/bash

crontab(){
    
cat <<EOF > /etc/crontab
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the 'crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
EOF

# 
echo "17 *  * * *  root  cd / && run-parts --report /etc/cron.hourly" >> /etc/crontab
echo "25 6  * * *  root  test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.daily )" >> /etc/crontab
echo "47 6  * * 7  root  test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.weekly )" >> /etc/crontab
echo "52 6  1 * *  root  test -x /usr/sbin/anacron || ( cd / && run-parts --report /etc/cron.monthly )" >> /etc/crontab
# 
echo "#" >> /etc/crontab
}

