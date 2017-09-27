#! /bin/bash

RET_VAL=$( curl localhost/test.php )
# Debugging line, if having issues with this test, try inspecting the returned value/.
# echo "Ret val is ${RET_VAL}";

# Because the apache test runs before this file, if we got here then we can
# safely assume that apache is working so test that our test.php file is returning TRUE and not text.
if [[ $RET_VAL != 1 ]]; then
    echo "test.php returned non-true value (assume text) indicating non-interpreted php - TEST FAILED."
    exit 1;
else
    echo "Test.php returned interpreted value of TRUE indicating php and apache are working - TEST PASSED."
fi   