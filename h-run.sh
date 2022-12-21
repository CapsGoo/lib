#!/usr/bin/env bash

. colors

CUSTOM_DIR=$(dirname "$BASH_SOURCE")

. $CUSTOM_DIR/h-manifest.conf

cd $CUSTOM_DIR

[[ -z $CUSTOM_LOG_BASEDIR ]] && echo -e "${RED}No CUSTOM_LOG_BASEDIR is set${NOCOLOR}" && exit 1
[[ -z $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}No CUSTOM_CONFIG_FILENAME is set${NOCOLOR}" && exit 1
[[ ! -f $CUSTOM_CONFIG_FILENAME ]] && echo -e "${RED}Custom config ${YELLOW}$CUSTOM_CONFIG_FILENAME${RED} is not found${NOCOLOR}" && exit 1

mkdir -p $CUSTOM_LOG_BASEDIR
touch $CUSTOM_LOG_BASENAME.log

source $CUSTOM_CONFIG_FILENAME
#touch $CUSTOM_CONFIG_FILENAME

./dynex -cpu-chips 4 -mining-address $WAL -no-gpu -stratum-url $HOST -stratum-port $PORT -stratum-password $PASS $EXTRA 2>&1 | tee --append $CUSTOM_LOG_BASENAME.log


