q=${config[quickReport]};
# assign int to vars so not errors from -gt
qFile=0;
qDir=0;
if [[ ! -f $q && ! -w $q ]]; then
    qFile=1;
fi

if [[ ! -d $q && ! -w  $q ]]; then
    qDir=1;
fi

if [  "$qDir" -gt 0 ]; then     
    if [ "$qFile" -gt 0 ]; then
         error "***ERROR*** quickReport path : $q is not valid";
    fi
fi

verbose "quickReport set : $q" 2;
