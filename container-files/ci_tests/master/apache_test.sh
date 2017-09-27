#! /bin/bash 

s6-svwait -t 5000 -U /var/run/s6/services/apache 

# Test to verify that the apache server is up and running.
HTTP_RESPONSE=$( curl -s -o /dev/null -w "%{http_code}" localhost/index.html )
if [[ $HTTP_RESPONSE != 200 ]]; then
    # If a file returned non-zero, print out that file so we have some testing recourse.
    echo "Apache Web Server returned a non-200 response code of ${HTTP_RESPONSE} - TEST FAILED."
    exit 1; 
else 
    echo "CURL request to localhost returned a response of ${HTTP_RESPONSE} - TEST PASSED."
fi