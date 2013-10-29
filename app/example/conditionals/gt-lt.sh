test=1
echo 'if you pass a string you will error';
if [[ "$test" -gt 0 ]]; then 
     echo 2;
fi;
if [ "$test" -gt 0 ]; then 
        
    echo 1;
fi;
if [[ "$test" -gt "0" ]]; then 
     echo '2 w "" ';
fi;
if [ "$test" -gt "0" ]; then 
        
    echo '1 w ""';
fi;
if [[ "$test" -lt 0 ]]; then 
     echo 2;
fi;
if [ "$test" -lt 0 ]; then 
        
    echo 1;
fi;
if [[ "$test" -lt "0"  ]]; then 
     echo '2 w "" ';
fi;
if [ "$test" -lt "0" ]; then 
        
    echo '1 w ""';
fi;
if [[ "$test" -lt "0" || "$test" -gt "0" ]]; then 
        
    echo 'cant fail here';
fi;
