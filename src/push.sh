#!/bin/bash

CATAPUSH_TOKEN=$CATAPUSH_TOKEN
LOG_FILE_PREFIX=/dev/shm/last_10_vpn_attempts.log
RECIPIENT=$PHONE_NUMBER
RUN_FREQUENCY_SECONDS=900

function pushnotify(){
    message=$@
    curl --request POST \
      --url https://api.catapush.com/1/messages \
      --header 'Accept: application/json' \
      --header 'Authorization: Bearer '"$CATAPUSH_TOKEN"'' \
      --header 'Content-Type: application/json' \
      --data '{"mobileAppId":318,"text":"'"$message"'","recipients":[{"identifier":"'"$RECIPIENT"'"}]}'
}

function handler_vpn(){
    log=$1
    sudo journalctl --boot --lines=all | grep "ovpn-server[[]" | grep "Peer Connection Initiated" | tail -10 > ${log}_new
    diff=$(diff ${log} ${log}_new)
    [ $(echo $diff | wc -w) -gt 0 ] && pushnotify $(echo "$(hostname): New VPN connect: $(echo $diff | cut -d ' ' -f 8-9)") || echo "No new VPN connections."
}

function main(){
    current_file=$0
    for handler in $(grep function $current_file | cut -d' ' -f2 | cut -d "(" -f1 | grep handler_);
    do
       echo $handler
       log=${LOG_FILE_PREFIX}_${handler}
       touch ${log} && $handler ${log}
       cp ${log}_new ${log}
    done
    sleep $RUN_FREQUENCY_SECONDS # Poor man's cron, since :ro on journal files and cron cannot write
}

while :; do main; done
