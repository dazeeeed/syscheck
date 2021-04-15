#!/bin/bash

let ipdev=0 #which device number
let first_run=1
touch /tmp/syscheck.cache

echo "IP Adresses" > /tmp/syscheck.cache
for i in $(ip addr | grep -P "\d+:\s[a-z0-9]+" -o); do
  echo -n $i$'\t' >> /tmp/syscheck.cache
  let ipdev+=1
  if ! (($ipdev % 2)); then
    echo $(ip addr | head -n $((($ipdev/2-1)*6 + 3)) | tail -n 1 | \
    grep -P "\s+inet\s[0-9]+.[0-9]+.[0-9]+.[0-9]+/[0-9]+" -o) >> /tmp/syscheck.cache
  fi
done

echo $'\n'"Total RAM installed" >> /tmp/syscheck.cache
echo $(free -h | grep -P "[a-zA-Z]+:\s+[1-9]+.[1-9]+[a-zA-Z]+" -o) >> /tmp/syscheck.cache

echo $'\n'"Number of processors:" $(cat /proc/cpuinfo | grep -c processor) >> /tmp/syscheck.cache

if [ -e logs.log ]; then
  let first_run=0
else
  touch logs.log
  echo "File logs.log created!"
  cat /tmp/syscheck.cache > logs.log
fi

if [ "$(diff logs.log /tmp/syscheck.cache)" != "" ] || [ $first_run -eq 1 ]; then
  cat /tmp/syscheck.cache > logs.log
  echo "Sending an email with current configuration!"
  cat logs.log | mail -s "Your computer parameters." test.mail.physics@gmail.com
else
  echo "Your system parameters didn't change."
fi
