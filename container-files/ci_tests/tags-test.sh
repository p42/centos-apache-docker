#! /bin/bash

# This file is used for tests specific to non-master branches. If the tests are the same, simply
# update the loop to iterate the master-tests directory or call the master-tests shell file.

# ESU10 CI Test structure is to call a single test file that iterates a directory of individual tests.
# In keeping with standard testing prodcedures, 
# each test should be singular (at least as much as is possible).


for file in /ci_tests/tags/*; do
    bash $file
    # $? gives us the exit code of the previous process (last file to run)
    # which allows us to print fail if a test fails. 
    # Please make sure and print reasons for failure.
    rc=$?
    if [[ $rc != 0 ]]; then
        # If a file returned non-zero, print out that file so we have some testing recourse.
        echo "${file} exited with non-zero exit code"
        exit $rc; 
    fi
done