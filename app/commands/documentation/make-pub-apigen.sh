apigenDir=${config[apigenDir]};

apigenCf='pub_doc.neon';

read -p 'change apigen dir? y || n ' cad

if [ "$cad" = "y" ]; then
    read -p '$apigenDir' apigenDir;
fi

read -p 'change apigen config file? y || n ' cacf

if [ "$cacf" = "y" ]; then
    read -p '$apigenCf' apigenCf;
fi

apigen --config  $apigenDir/$apigenCf;





