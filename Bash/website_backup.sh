#!/bin/bash

#Dirs being backed
SOURCE_DIRS="/path/to/dir /path/dir /path/dir"

#Destination
BACKUP_DIR="/path/to/backup"
DATE=$(date +"%Y-%m-%d")
BACKUP_FILE="$BACKUP_DIR/full_backup_$DATE.tar.gz"

#Log File
LOGFILE="/path/to/backup.log"

#Make Backup dir
mkdir -p "$BACKUP_DIR"

#Create Backup
tar -czf "$BACKUP_FILE" $SOURCE_DIRS

#Check if successful
if [ $? -eq 0 ]; then
	MESSAGE="[$DATE] Backup Successful: $BACKUP_FILE"
else
	MESSAGE="[$DATE] Backup FAILED"
fi

#Write Log
echo "$MESSAGE" >> "$LOGFILE"

#Email Result
echo "$MESSAGE" | mail -s "Webserver Backup Status ($DATE)" example@gmail.com
