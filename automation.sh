#!/bin/bash

#--- package update ----
sudo apt update -y

#-- installation of apache2--
 sudo apt install apache2 -y
        echo "apache installed"

sudo systemctl unmask apache2

#-- Check apache2 is running
if [ `service apache2 status | grep running | wc -l` == 1 ]
then
        echo "Apache2 running"
else
                sudo service apache2 start
        echo "apache2 started"
fi

#--- Check apache2 is enabled 
if [ `service apache2 status | grep enabled | wc -l` == 1 ]
then
        echo "Apache2 already enabled"
else
                sudo systemctl enable apache2
        echo "Apache2 enabled"
fi

#-- Creating a tar for logs
timestamp=$(date '+%d%m%Y-%H%M%S')

cd /var/log/apache2/
tar -cvf /tmp/${name}-httpd-logs-${timestamp}.tar *.log

#-- Copy to s3

aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar

if [ -e /var/www/html/inventory.html ]
then
        echo "Inventory exists"
else
        touch /var/www/html/inventory.html
        echo "<b>Log Type &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Date Created &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Type &nbsp;&nbsp;$
fi
echo "<br>httpd-logs &nbsp;&nbsp;&nbsp;&nbsp; ${timestp} &nbsp;&nbsp;&nbsp;&nbsp; tar &nbsp;&nbsp;&nbsp;&nbsp; `du -h $
if [ -e /etc/cron.d/automation ]
then
        echo "Cron job exists"
else
        touch /etc/cron.d/automation
        echo "0 0 * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
        echo "Cron job added"
fi
