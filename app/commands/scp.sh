
u="";
h="";
r=""; #to read

#readPKFile;
echo "user $u";

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

readRDir()
{
    rDL=$( verbose "dir GET copy " );
    read -p "$rDL " r;
    if [ ! "$r" ]; then
        verbose "required** remote host " 1;
        readRDir;

        return;
    fi;

    return 0;
}
readRDir;


doCp()
{   
    
    u="$1";
    h="$2";
    d="$3"; 
    verbose "doing scp $u $h  $d" ;
    echo "user $u";
    echo "pk $pK"
    scp -r $u'@'$h:$d .
    return;
    if [ ! -f "$1" ]; then
        echo 1;
        echo "scp -r $u@$h:$d ." 3;
        scp  "-r $u@$h:$d .";
          
        return;
    fi;
    echo 2;
    verbose "scp -i  $u@$h:$d ." ;
    scp "-i $u@$h:$d ." ;

    return;
}
echo "user $u";
  
echo " $u $h $r";
doCp  $u $h $r;

