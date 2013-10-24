loop=true;

verbose 'including config based project aliases' 3;
verbose "${config[projectAliases]}" 3;
. ${config[projectAliases]} ;
        
verbose 'command || b || back ' 0;
while [ "$loop" == "true" ] 
    do       
        read -p 'commandd > ' commandd
        
        if [ "$commandd" = "back" ]; then  
            verbose 'commandd is back : unsetting loop' 3;
            unset loop;
        fi
        
        if [ "$commandd" = "b" ]; then
            verbose 'commandd is b : unsetting loop' 3;
            unset loop;
        fi
        
        if [ $loop ]; then
            verbose "going to evaluate $commandd" 3;
            $commandd; 
        fi     

    done
