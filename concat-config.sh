#!/usr/bin/env bash

#
#	This script concatenates various config files into one
#	config file for i3 to use at start up.
#	
#	Since i3's config lacks an include statement,
#	this script replecates that behavior
#

I3DIR=$HOME/.i3
LOG_FILE=$HOME/.logs/i3_concat_config

logger () {
	echo $1;
	echo "$(date +%c) : $1" >> $LOG_FILE;
}

if ! [ -d $HOME/.logs ]; then
	mkdir -p $HOME/.logs
fi

if ! [ -d $I3DIR/configs ]; then
	logger "ERROR - $i3DIR/configs directory does not exist";
	exit 1;
fi

if ! [ "$(ls -A $I3DIR/configs)" ]; then
	logger "ERROR - $CONFIG_DIR/configs is empty, doing nothing";

	if ! [ $I3DIR/config ]; then
		logger "$I3DIR/config does not exist already, creating a default config"
		parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
		cp $parent_path/default_config $I3DIR/config
	fi
	exit 1;
fi

if [ -f $I3DIR/config ]; then
	mv -f  $I3DIR/config $I3DIR/config.old
fi

cat $I3DIR/configs/* > $I3DIR/config

#for f in $I3DIR/configs/*
#do
#	cat $f >> $I3DIR/config
#done

logger "config successfully created in $I3DIR"
