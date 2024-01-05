#!/bin/sh
# show the web page as soon as hamclock is available.
# monitor hamclock and surf
# refresh page when hamclock is back again
# (based on ideas of thuban@singularity.fr)

HAMCLOCKURL=http://localhost:8081/live.html
DELAY=1

# wait the desktop system
sleep 30

# launch browser
echo launch surf $HAMCLOCKURL ...
/usr/bin/surf -F $HAMCLOCKURL & SURFPID=$!
echo pid=$SURFPID.

# wait for browser ...
sleep 30

# launch hamclock
echo hamclock ...
/usr/local/bin/hamclock &
echo pid=$!

# wait for hamclock page
CURLERROR=1
until [ "${CURLERROR}" -eq "0" ] ; do
	echo check hamclock ...
	sleep $DELAY
	curl -s $HAMCLOCKURL > /dev/null
	CURLERROR=$?
done
echo "hamclock is up :-)"

# reload page
kill -HUP $SURFPID

exit 0
