#!/bin/bash
echo "THE SCRIPT TO RESTART THE SERVER IS RUNNING! ON: "
whoami

strdev="DEV"
strprod="PROD"
strtest="TEST"

if [ $1 == $strdev ]; then
  echo "- DEVELOPMENT ENV IS SETTING UP!"
  sudo kill -9 `cat 2003` #$(sudo lsof -t -i:5005)
  nohup rails s -p 3005 -P 2003 & 
else
  if [ $1 == $strprod ]; then
    echo "- PRODUCTION ENV IS SETTING UP!"
    kill -9 `cat 2004` #$(sudo lsof -t -i:5006)
    rails s -e production -d -p 3000 -P 2004 #nohup rails s -p 5006 -P 2004 &
  else
    if [ $1 == $strtest ]; then
      echo "- TEST ENV IS SETTING UP!"
      kill -9 `cat 2005` #$(sudo lsof -t -i:5007)
      rails s -e test -d -p 3007 -P 2005 #nohup rails s -p 5007 -P 2005 &
    else
      echo "ERROR! INVALID ENVIRONMENT!"
    fi
  fi
fi

#rails s -e production -d
#-b 172.26.1.134
#-b ec2-18-222-177-88.us-east-2.compute.amazonaws.com -p 3000 -P 2003 &  

#DEV    - nohup rails s -p 5005 -P 2003 & 
#PROD   - nohup rails s -p 5006 -P 2004 &
#TEST   - nohup rails s -p 5007 -P 2005 &