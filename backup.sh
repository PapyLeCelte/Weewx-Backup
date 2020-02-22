#!/bin/bash
##########################################
#
# Weewx Backup script for Raspberry pi
#
# PapyLeCelte
#
##########################################

#Mount USB key and stop weewx daemont

mount /dev/sdb1 /media/backup
/etc/init.d/weewx stop

# What to backup. 
backup_files1="/var/lib/weewx/weewx.sdb"
backup_files2="/etc/weewx/weewx.conf"
backup_files3="/etc/weewx/skins"
backup_files4="/usr/share/weewx/user"
backup_files5="/home/pi/Camera"

# Where to backup to.
dest="/media/backup"

# Create archive filename.
day=$(date +%A)
hostname=$(hostname -s)
archive_file="$hostname-$day.tgz"

# Print start status message.
echo "Backing up $backup_files1 to $dest/$archive_file"
echo "Backing up $backup_files2 to $dest/$archive_file"
echo "Backing up $backup_files3 to $dest/$archive_file"
echo "Backing up $backup_files4 to $dest/$archive_file"
echo "Backing up $backup_files5 to $dest/$archive_file"
date
echo

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files1 $backup_files2 $backup_files3 $backup_files4 $backup_files5

# Print end status message.
echo
echo "Backup finished"
date

#Unmount USB key and restart Weewx
umount /dev/sdb1
/etc/init.d/weewx restart

# Long listing of files in $dest to check file sizes.
ls -lh $dest
