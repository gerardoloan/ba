
u="";
h="";
r=""; #to read

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
echo "user $u";

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

verbose "Directories are from the base directory" 1;
verbose "No ~/ " 1;
readRDir()
{
    rDL=$( verbose "copy from" );
    read -p "$rDL " r;
    if [ ! "$r" ]; then
        verbose "required** remote host " 1;
        readRDir;

        return;
    fi;

    return 0;
}
readRDir;

rLL=$( verbose "Copy to (if not supplied from path will be used)" );
read -p "$rLL " l;
if [ ! "$l" ]; then 
    l="$r";
    verbose "will copy to $l" 1;
fi;
readUPK()
{
    uPKL=$( verbose "ssh keys from standard place? 0 || 1" );    
    read -p "$uPKL " uPK;
    echo $uPK;
    if [[  "$uPK" = "0" ||  "$uPK" = "1" ]]; then
        return;
    fi; 
    
    verbose "must answer 0 || 1" 1;
    readUPK; 
    
    return;
}
readUPK;

doCp()
{   
    
    u="$1";
    h="$2";
    d="$3"; 
    l="$4";
    verbose "doing scp $u $h  $d $l" ;
    
    echo "scp -r $u@$h:$d $l" ;
    scp  -r $u@$h:~/$d ~/$l;
          
    return;    
}

pKCp()
{
    u="$1";
    h="$2";
    d="$3"; 
    l="$4";
    verbose "scp -r -i ~/.ssh/id_rsa.pub $u@$h:~/$d $l" ;
    scp -r -i ~/.ssh/id_rsa.pub $u@$h:~/$d $l;

    return;
}
pickCpType()
{
    u="$1";
    h="$2";
    d="$3"; 
    l="$4";
    uPK="$5";
    echo " $u $h $r $l";
    if [ "$uPK" = "1" ]; then 
        pKCp $u $h $r $l;
    fi;
    if [ "$uPK" = "0" ]; then 
        doCp $u $h $r $l;
    fi;
}
pickCpType $u $h $r $l $uPK;

