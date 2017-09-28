#!/bin/with-contenv sh

s6-svwait -t 5000 -U /var/run/s6/services/apache

HTML_DESTINATION=${HTML_DESTINATION:=localhost/index.html}

# We're having some issues with startup sequencing where this script is being executed before
# apache is fully ready - even though the above should wait until that's the case.
# As a temporary workaround, we're going to put in a series of s6-svwait commands if we
# don't get a 200 response. If, after several tries it still isn't responding then
# it's safe to assume that Apache isn't configured correctly.

RETRY_LIMIT=5
RETRY_TIMES=0
HTTP_RESPONSE=0

# Since retry times implies the times that you're trying AGAIN, try the first time to touch the server.
HTTP_RESPONSE=$( curl -s -o /dev/null -w "%{http_code}" $HTML_DESTINATION )

while [[ $HTTP_RESPONSE != 200 ]] && (( ${RETRY_LIMIT} > ${RETRY_TIMES} ))
do
    s6-svwait -t 5000 -U /var/run/s6/services/apache 
    echo "${RETRY_TIMES} - in the loop"
    (( RETRY_TIMES = RETRY_TIMES + 1 ))
    HTTP_RESPONSE=$( curl -s -o /dev/null -w "%{http_code}" $HTML_DESTINATION )
    echo "${HTTP_RESPONSE} response received after ${RETRY_TIMES} tries"
done

# Test to verify that the apache server is up and running.
if [[ $HTTP_RESPONSE != 200 && RETRY_TIMES -eq RETRY_LIMIT ]]; then
    # If a file returned non-zero, print out that file so we have some testing recourse.
    echo "Apache Web Server returned a non-200 response code of ${HTTP_RESPONSE} after ${RETRY_TIMES} retries - TEST FAILED."
    exit 1; 
else 
    echo "CURL request to localhost returned a response of ${HTTP_RESPONSE} - TEST PASSED."
fi

