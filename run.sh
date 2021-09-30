#!/bin/bash
#!/bin/bash

LOG_FILE=/dev/shm/last_10_vpn_attempts.log
RECEIPIENT=$PHONE_NUMBER
TOKEN=$CATAPUSH_TOKEN

function send_notification(){
    message=$@
    curl --request POST \
      --url https://api.catapush.com/1/messages \
      --header 'Accept: application/json' \
      --header 'Authorization: Bearer '"$TOKEN"'' \
      --header 'Content-Type: application/json' \
      --data '{"mobileAppId":318,"text":"'"$message"'","recipients":[{"identifier":"'"$RECEIPIENT"'"}]}'
}

function handle_new_vpn_connections_detected(){
    diff=$@
    message=$(echo "$(hostname): New VPN connections detected. $(echo $diff | cut -d ' ' -f 8-9)")
    send_notification $message
}

function get_last_unique_vpn_connections(){
    sudo journalctl --boot --lines=all | grep "ovpn-server[[]" | grep "Peer Connection Initiated" | tail -10 > ${LOG_FILE}_new
}
get_last_unique_vpn_connections
diff=$(diff ${LOG_FILE} ${LOG_FILE}_new)
[ $(echo $diff | wc -w) -gt 0 ] && handle_new_vpn_connections_detected $diff || echo "No new VPN connections."
cp ${LOG_FILE}_new ${LOG_FILE}
