#!/bin/bash

interval=${1:-500}

while true; do
	if ping -c 1 -q ece2524.ece.vt.edu &>/dev/null; then
		nanoc sync
		nanoc co && nanoc deploy --target cvl
	else
		echo "Host not pingable" >&2
	fi
	echo "Sleeping for $interval" >&2 && sleep $interval
done
