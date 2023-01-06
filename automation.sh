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

