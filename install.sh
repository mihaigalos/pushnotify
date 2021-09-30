#!/bin/bash

source /home/$SUDO_USER/.profile
if [[ -z "$CATAPUSH_TOKEN" || -z "$PHONE_NUMBER" ]]; then
     cat <<EOT
     ERROR: Variables not set.
     Please set the following environment variable in your non-root user's ~/.profile
        CATAPUSH_TOKEN
        PHONE_NUMBER
EOT
  exit 1
fi

cat <<EOF >>/var/spool/cron/crontabs/root
*/15 * * * * /bin/bash -c "source /home/$SUDO_USER/.profile && $(realpath run.sh)"
EOF
