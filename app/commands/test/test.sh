testDir=${config[testDir]};
cd $testDir;

export XDEBUG_CONFIG="idekey=netbeans-xdebug"; 
phpunit


