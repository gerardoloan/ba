
#validate $apigenDir file write 

apigenDir=${config[ apigenDir ]}

if [ !  -w $apigenDir ]; then
    apigenDirIsNotFile=1;
fi
if [ !  -f $apigenDir ]; then
    apigenDirIsNotFile=1;
fi

#validate $apigenDir dir write 
if [ ! -d $apigenDir ]; then
    apigenDirIsNotDir=1;
fi

if [ ! -w $apigenDir ]; then
    apigenDirIsNotDir=1;
fi

if [  "$apigenDirIsNotDir" == 1 ]; then 
    
    if [ "$apigenDirIsNotFile" == 1 ]; then
         error "***ERROR***path : $apigenDir is not valid";
    fi
fi
if [ !  -r '/usr/share/php/Nette/loader.php' ]; then
    depError '***ERROR*** -r /usr/share/php/Nette/loader.php' apigen;
fi;
if [ !  -r  '/usr/share/php/texy/src/texy.php' ]; then
    depError '***ERROR*** -r /usr/share/php/texy/src/texy.php' apigen;
fi;



printConfigValidation '$apigenDir set : '$apigenDir 1 $verbosity;
