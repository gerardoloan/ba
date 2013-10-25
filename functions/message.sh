verbose()
{   
    local m;
    local v;
    local sV;
    
    m="$1";   
    v="$2";
    sV=${config[sysVerbosity]};  
  
    if [[ ! "$v"  =~ [[:digit:]] ]]; then
        #colorMessage 'easy digit mathcing here ' 6; 
        echo $m;
        
        return;
    fi
    
    if [[ ! "$sV"  =~ [[:digit:]] ]]; then
        #colorMessage 'cant let a none digit fall through here' 6; 
        sV=1;
    fi
    
    #base system verbosity level
    if [ "$v" = 1 ]; then
       colorMessage "$m" "$v";
       
       return;
    fi
    
    #message has +int verbosity not 1 
    #is less than system return null
    if [ "$v" -gt "$sV" ]; then
        #colorMessage 'only one bracket here if [ "$v" -gt "$sV" ] ?';
        
        return;
    fi

    colorMessage "$m" "$v";

    return;
}

colorMessage()
{
    getColor()
    {
        declare -a colors;
        colors[0]=196; # 196 orangy red 0
        colors[1]=9; # red
        colors[2]=2; # green 
        colors[3]=4; # purple
        colors[4]=17; # blue
        colors[5]=12; # l purple
        colors[6]=39; # light blue
        colors[7]=199; # bright purple
        
        if [[ $1 =~ [[:digit:]] ]]; then
            echo ${colors[$1]};
            
            return;
        fi;

        echo 1;
        
    }
    #message $1
    #color $2
    local nocolors=${config[nocolors]};

    if [  "$nocolors" = "1" ]; then 
        echo $1;
        
        return;
    fi;  
    
    c=$( getColor $2 );
    echo -en "\E[0;48;5;"$c"m $1 \E[0m\n";
    
    return
}




echoInitConfig()
{
    verbose 'valiadating config ...' 3;

    verbose 'this process warns and only sometimes exits :) ' 3;
    verbose 'read the output...' 3;

    return;
}

error()
{   
    echo $1;
    exit;
}
depError()
{
    echo "dependency error in $2 package";
    error "$1";
}

childMessages()
{
    verbose ":() why? because we can"  7;
    verbose 'children cristian lua | space-tool astronots' 7; 
    verbose 'never stop the revolution' 7;
}

