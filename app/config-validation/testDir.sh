tD=${config[testDir]};

if [ ! -d $tD ]; then
    error "dir: $tD is not valid dir"; 1  
fi

if [ ! -r $tD/phpunit.xml ]; then    
    error "file $tD/phpunit.xml not found" 1
fi

if [ ! -r $tD/fastphpunit.xml ]; then   
    error "file $tD/fastphpunit.xml not found" 1
fi

verbose "testDir set : $tD" 2;
