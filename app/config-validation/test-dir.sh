testDir=${config[testDir]};

if [ ! -d $testDir ]; then
    error "dir: $testDir is not valid dir"; 1  
fi

if [ ! -f $testDir/phpunit.xml ]; then    
    error "file $testDir/phpunit.xml not found" 1
fi

if [ ! -f $testDir/fastphpunit.xml ]; then   
    error "file $testDir/fastphpunit.xml not found" 1
fi

verbose "testDir set : $testDir" 2;
