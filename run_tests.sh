#!/bin/bash

cd /opt/metwork-mfext/opt/integration_tests

ret=0
for rep in test*; do
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
done
exit $ret
