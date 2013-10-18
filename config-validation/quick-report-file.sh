quickReportFile=${config[quickReportFile]};
if [ ! -f $quickReportFile ]; then
    quickReportFileIsNotFile=1;
fi

if [ ! -d $quickReportFile ]; then
    quickReportFileIsNotDir=1;
fi

if [  "$quickReportFileIsNotDir" == 1 ]; then 
    
    if [ "$quickReportFileIsNotFile" == 1 ]; then
         error "***ERROR***  path : $quickReportFile is not valid";
    fi
fi

printConfigValidation '$quickReportFile set : '$quickReportFile 1 $verbosity;