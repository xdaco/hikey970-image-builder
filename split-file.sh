#!/usr/bin/env bash
FILE=$1
FILESIZE=$(stat -c%s "$FILE")

if (( FILESIZE > 1024000000 )) ;then
    echo "$FILE is greater than 1Gb in size. Splitting it...."
    zcat $FILE | split - -b 1G --filter='gzip > $FILE.gz' $FILE.part

else
	echo "$FILE is less than 1Gb in size. Leaving it in its original state"
fi