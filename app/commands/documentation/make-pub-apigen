apigenDir=${config[apigenDir]};

apigenCf='pub_doc.neon';

read -p 'change apigen dir? 0 || 1 ' cad

if [ "$cad" = "1" ]; then
    read -p '$apigenDir' apigenDir;
fi

read -p 'change apigen config file? 0 || 1 ' cacf

if [ "$cacf" = "1" ]; then
    read -p '$apigenCf' apigenCf;
fi

apigen --config  $apigenDir/$apigenCf;





