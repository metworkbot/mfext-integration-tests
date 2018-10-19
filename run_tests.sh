#!/bin/bash

if [ ! -d /opt/metwork-mfext/opt/integration_tests ]; then
    echo "There are no integration tests available"
    echo "The rpm mfext-integration-tests is probably not existing for this branch"
    exit 0
else
    cd /opt/metwork-mfext/opt/integration_tests
fi

ret=0
for rep in test*; do
    if [ -d $rep ]; then
        cd $rep
        LAYERS_TO_LOAD=`cat .layerapi2_dependencies |xargs |sed 's/ /,/g'`
        for test in test*.sh; do 
            echo "Test" $test "in" $rep
            layer_wrapper --layers=$LAYERS_TO_LOAD -- ./$test
            if test $? == 0; then
                echo "Test OK"
            else
                echo "Test KO"
                ret=1
            fi
        done
        cd ..
    fi
done
exit $ret
