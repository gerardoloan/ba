test="b"
echo 'once again matching with one or 2 brackets'
if [ "$test" = 'b' ]; then 
     echo b;
fi;
if [ "$test" = 'ba' ]; then         
    echo ba;
fi;
if [[ "$test" = "b" ]]; then 
     echo 'b w ]]';
fi;
test=1;
if [[ "$test" = "1" ]]; then 
     echo 'matching numbers too';
fi;
