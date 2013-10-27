let "instances = ${#config[*]} - 1"
verbose 'count : '$instances;

declare -a configKeys 
count=0;
for entry in  ${!config[*]}
    do
        
        configKeys["$count"]=$entry;
        ((count++));

    done
count=0;
for entry in  ${config[*]}
    do

        label=${configKeys["$count"]};
       
        verbose  $label' : '$entry;
        ((count++));

    done




