#!/bin/bash
#Filename: twitter.sh
#Description: Basic twitter client

oauth_consumer_key=YOUR_CONSUMER_KEY
oauth_consumer_secret=YOUR_CONSUMER_SECRET
config_file=~/.$oauth_consumer_key-$oauth_consumer_secret-rc 

if [[ "$1" != "read" ]] && [[ "$1" != "tweet" ]];
then 
  echo -e "Usage: $0 tweet status_message\n   OR\n      $0 read\n"
  exit -1;
fi

source TwitterOAuth.sh
TO_init

if [ ! -e $config_file ]; then
 TO_access_token_helper
 if (( $? == 0 )); then
   echo oauth_token=${TO_ret[0]} > $config_file
   echo oauth_token_secret=${TO_ret[1]} >> $config_file
 fi
fi

source $config_file

if [[ "$1" = "read" ]];
then
  TO_statuses_home_timeline '' 'shantanutushar' '10'
  echo $TO_ret | sed 's/<\([a-z]\)/\n<\1/g' | \
grep -e '^<text>' -e '^<name>' | sed 's/<name>/\ - by /g' | \
sed 's$</*[a-z]*>$$g'

elif [[ "$1" = "tweet" ]];
then 
  shift
  TO_statuses_update '' "$@"
  echo 'Tweeted :)'
fi