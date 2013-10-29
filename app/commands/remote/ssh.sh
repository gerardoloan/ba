u="";
h="";
 #to read

readUser()
{
    uL=$( verbose "user" );
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
    local rHL=$( verbose "remote host" );
    
    read -p "$rHL " h;
    
    if [ ! "$h" ]; then
        verbose "required** remote host " 1;
        readHost;

        return;
    fi;

    verbose "Using host $h" 1;
    
    return 0;
}
readHost;

readCDPK()
{
    change()
    {
        if [[  "$cDPK" = 'y' ]]; then
            nPKL=$( verbose "New file..." );
            read -p "$nPKL " nPK;
            verbose "Using key path : $nPK" 1;  
     
            return;   
        fi;
    }
    local cDPKL=$( verbose "change default ssh key? y || n" );
    cDPK=n;
    read -p "$cDPKL " cDPK;
    
    if [[  "$cDPK" = 'n' ]]; then         
        verbose "Using default key path" 1;  
        
        return;
    else
 
    change;  
    
    fi;  

    verbose "please enter y || n" 1;
   
     
    return;
}

readUDPK()
{
    
    local uDPKL=$( verbose "use a ssh key? y || n" );
    uDPK="";
    read -p "$uDPKL " uDPK;

    if [[ "$uDPK" = "y" ]]; then 
        
        verbose "Using a key path" 1;  
        
 
        return 0;
    fi;

    if [ "$uDPK" = "n" ]; then 
        
        verbose "Not using a key path" 1;          
 
        return 0;
    fi;
    
    verbose "please enter y || n" 1;
    readUDPK;

    return 1;
}
readUDPK;

warnUseExit()
{
    verbose "use exit to stay in the space tool" 1;
}

doSsh()
{
    u="$1";
    h="$2";
    uDPK="$3";
    nPK="$4";

    if [ "$uDPK" = "y" ]; then 
        pk='.ssh/id_rsa.pub';
        readCDPK;
        verbose "ssh -i ~/.ssh/id_rsa.pub' $u@$h;" 1;
        warnUseExit;
        ssh -i ~/$pK $u@$h;
  
        return;    
    fi;

    verbose "ssh $u@$h" 1;
    warnUseExit;
    ssh $u@$h;

    return;
}

doSsh $u $h $uDPK $pK;





