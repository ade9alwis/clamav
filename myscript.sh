#!/bin/bash

#Define the virus backup path(s) 

#BKP_PATH=/tmp/clamav

#Define the process report destination

#REP_DEST=/var/log/clamav

#Define the scan path(s)

#SCAN_PATH=/home/john /var/pub/ftp

BLANK=" "                                                                    

today1=$(date +"%F_%T")

echo "Beginning of ClamAV Virus Scanning Process on : '$today1' " >>$REP_DEST/scan_$today1.log

echo "=========================================================================" >>$REP_DEST/scan_$today1.log

echo "$BLANK" >>$REP_DEST/scan_$today1.log

freshclam >>$REP_DEST/scan_$today1.log

today2=$(date +"%F_%T")

echo "$BLANK" >>$REP_DEST/scan_$today1.log

echo "-------Beginning of Virus Scanning at '$today2'------" >>$REP_DEST/scan_$today1.log

echo "$BLANK" >>$REP_DEST/scan_$today1.log

# This operation you can comment out if you have defined the path before 

mkdir -p $BKP_PATH $REP_DEST $SCAN_PATH

#Option 1
#This is the safest option because it gives us an indication of a virus and
#extracts it into the defined path and it is not remove the virus from it’s original location. 
#Later we can decide what action is necessary to mitigate this issue.

clamscan --recursive --infected --copy=$BKP_PATH --exclude-dir=$BKP_PATH  $SCAN_PATH >>$REP_DEST/scan_$today1.log

#Option 2
#This is relatively safer, but there can be  issues, if the virus affects the boot or any other system files.
#It move all into backup destination and then next reboot might be a issue. 

#clamscan --recursive --infected --move=$BKP_PATH --exclude-dir=$BKP_PATH  $SCAN_PATH >>$REP_DEST/scan_$today1.log

#Option 3
#This is very unsafe, if it identify the infected files on the system system, it clear them all with out inquiring. 
#So, think twice before selecting this option.

#clamscan --recursive --infected --remove --exclude-dir=$BKP_PATH   $SCAN_PATH >>$REP_DEST/scan_$today1.log
    
today3=$(date +"%F_%T")

echo "$BLANK" >>$REP_DEST/scan_$today1.log

echo "--------End of scanning process at '$today3'--------" >> $REP_DEST/scan_$today1.log


