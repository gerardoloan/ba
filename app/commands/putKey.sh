u="";
h="";
f=""; #to read

readUser()
{
    uL=$( verbose "user " );
    read -p "$uL " u;
    if [ ! "$u" ]; then
        verbose "required** remote user " 1;
        readUser;

        return;
    fi;
    
    verbose "User is $u" 1;
    
    return 0;
}
readUser;

readHost()
{
    rHL=$( verbose "remote host " );
    read -p "$rHL " h;
    if [ ! "$rHL" ]; then
        verbose "required** remote host " 1;
        readHost;

        return 1;
    fi;

    verbose "Using host $h" 1;
    
    return 0;
}
readHost;

readCDPKL()
{
    cDPKL=$( verbose "change default ssh key? y || n" );
    read -p "$cDPKL " cDPK;

    if [[ "$cDPK" = "n" ]]; then 
        
        verbose "Using default key path" 1;  
        
        return 0;
    fi;

    if [[ "$cDPK" = "y" ]]; then
        nPKL=$( verbose "New file..." );
        read -p "$nPKL " nPK;
    
        verbose "Using key path : $nPK" 1;  
        
        return 0;  
    fi;
     
    verbose "please enter yes or no" 1;
    readCDPKL;

    return 1;
}
readCDPKL;
getPK()
{
    if [[ "$nPK" ]]; then
        echo "";

        return;
    fi
    if [[ -f "$nPK" ]]; then 
        
       return; 
    fi;

    return;
}
pK=$( getPK $nPK );
( echo "" | ssh $u@$h );

















