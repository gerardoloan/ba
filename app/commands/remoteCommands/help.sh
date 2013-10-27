readPKFile()
{
    pKL=$( verbose "public key file: [ d ] " );
    read -p "$pKL " pK;
    if [ "$pKL" = "d" ]; then 
        pK="~/.ssh/id_rsa";
        verbose "using $pk";
        return;
    fi;

    return;
}
readPKFile;
readUser()
{
    uL=$( verbose "user " );
    read -p "$uL " u;
    if [ ! "$u" ]; then
        verbose "required** remote user " 1;
        readUser;

        return;
    fi;

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

        return;
    fi;

    return 0;
}
readHost;

readRDir()
{
    rDL=$( verbose "dir GET copy " );
    read -p "$rDL " r;
    if [ ! "$u" ]; then
        verbose "required** remote host " 1;
        readRDir;

        return;
    fi;

    return 0;
}
readRDir;
readLDir()
{
    #rLL=$( verbose "dir to PUT copy " );
    read -p "dir to PUT copy " lD;
    if [ ! "$lD" ]; then
        verbose "required** " 1;
        verbose "dir to PUT copy";
        readLDir;

        return;
    fi;

    return;
}

#readLDir;

doCp()
{    
    verbose "doing scp $1 $2 $3  $4" ;
    if [ ! -f "$1" ]; then
        
        verbose "scp $2@$3:$4 ." 3;
        scp  "$2@$3:$4 .";
          
        return;
    fi;
    
    verbose "scp -i $1 $2@$3:$4 ." ;
    scp "-i $1 $2@$3:$4 ." ;

    return;
}

doCp $pK $u $h $r;

