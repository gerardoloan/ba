buildReduction()
{
    ret="";
    for(( i=0; i<"$1"; i++ )) do
        ret=$ret/..;
    done
    echo $ret;
}
buildReduction 3;
test=1
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
if [[ "$test" -lt "0" ]]; then 
     echo '2 w "" ';
fi;
if [ "$test" -lt "0" ]; then 
        
    echo '1 w ""';
fi;
