#!/bin/bash

######### Edit here ##########
#changelog1.1
Rec_user=receipient@domain.com # Set this to your email id to receive alerts on mail queue
sen_user=sender@domain.com
limit="200" # Set the limit here

##############################
logdate=`date +%d%b_%H:%M`

result="/tmp/$logdate.txt"
queue="`/usr/sbin/exim -bpc`"
summary=$(/usr/sbin/exim -bp | /usr/sbin/exiqsumm)

clear;

if [ "$queue" -ge "$limit" ]
then
echo "Current queue is: $queue" > $result
echo "Summary of Mail queue" >> $result
echo "$summary" >> $result
/bin/mail -s "Number of mails on `hostname` : $queue" -r "Mail_Queue_Alert!!<$sen_user>" $Rec_user < $result
cat $result
fi
rm -rf $result
