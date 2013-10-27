launchHelpers()
{
    launchHelp()
    {
        echoDirList()
        {
            prepareCommandPath;
            verbose 'echoing directory list '$fullCP;
            cd $fullCP;
            
            count=0;
            
            for file in ./*; do
                if [ -f "$file" ]; then 
                echo $file' '$count;
                ((count++));   
                fi;
            done;

            return;
        }
        claimItAndDoIt()
        {
            if [ "$commandd" = "help" ]; then  
                prepareBack 1;  
                echoDirList;
                verbose "help claimed $commandd" 3;  
                claimed=1;
            fi; 
            if [ "$commandd" = "h" ]; then  
                prepareBack 1;  
                echoDirList;
                verbose "h claimed $commandd" 3;
                claimed=1;
            fi; 

            return;
        }
        claimItAndDoIt;		
                     
    }
    launchMan()
    {
        actionMan()
        {            
            switchFullPath()
            {                 
                buildYourCommandd()
                {                
                    commandd=$num;
                
                    verbose "inserting $commandd" 3;
                
                    intToStringCommandd;
                
                    verbose "prepareForward $commandd" 3;
                    
                    prepareForward $commandd;
                
                    p="$commandPath/../man";

                    verbose "prepare command path with $p" 3;
                
                    prepareCommandPath "$p";

                    aMC=$fullCP.txt
                
                    verbose "action man command $aMC" 3;
                
                    prepareBack 1;  
                } 
                           
                buildYourCommandd;                            
            }
            switchFullPath;
            if [ -f "$aMC" ]; then
                echo "the cat is helping you some info from $aMC" 3; 
                cat $aMC;  
                
                return;
            fi; 
            
            verbose 'sorry havent got help, dig into the manual then write it please' 1; 
            verbose 'put the file in app/man/<same as in commands>.txt' 1;          
        }
        claimItAndDoIt()
        {
            if [[ ! "$num" &&  "$commandd" = "man" || "$commandd" = "m" ]]; then  
                prepareBack 1;
                verbose 'you need to enter the number of the service you want' 1;
                return;                
            fi;
            if [ "$commandd" = "man" ]; then
                verbose 'use = for strings' 4;  
                prepareBack 1;  
                actionMan;
                verbose 'man claimed and done it' 3;
                claimed=1;
            fi; 
            if [ "$commandd" = "m" ]; then  
                prepareBack 1;
                actionMan;
                verbose 'm claimed and done it' 3;
                claimed=1;
            fi;   
        }
        claimItAndDoIt;    
    }
    local claimed=0;
    
    launchHelp;
    launchMan;
    h=$claimed;
    verbose "returning int from launch helpers $h" 3;
}

