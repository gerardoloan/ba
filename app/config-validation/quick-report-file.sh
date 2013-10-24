q=${config[quickReportFile]};
if [[ ! -f $q && ! -w $q ]]; then
    qFile=1;
fi

if [[ ! -d $q && ! -w  $q ]]; then
    qDir=1;
fi

if [  "$qDir" = 1 ]; then 
    
    if [ "$qFile" = 1 ]; then
         error "***ERROR***  path : $quickReportFile is not valid";
    fi
fi

printConfigValidation '$quickReportFile set : '$quickReportFile 1 $verbosity;
