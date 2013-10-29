compareDir()
{    
    doComparison()
    {
        if [ "$priCS" = "$nCSC" ]; then
            verbose 'workMore' 1;
            
            if [[ ! -f /var/tmp/space-tool/comDirFalse ]]; then
                touch /var/tmp/space-tool/comDirFalse;
            fi;

            mv  /var/tmp/space-tool/comDirFalse /var/tmp/space-tool/comDirTrue;
            
            return 1;
        fi;

        if [[ ! -f /var/tmp/space-tool/comDirTrue ]]; then
                touch /var/tmp/space-tool/comDirTrue;
        fi;

        mv  /var/tmp/space-tool/comDirTrue /var/tmp/space-tool/comDirFalse	;
        verbose "never stop the revolution" 1;

        return 0;
    }
    prepareCheckSum()
    {
        nCS=$( ls -lRF | md5sum );
        echo $nCS >> ./.y;

        return;
    }
    getNewCk()
    {
        nCSC=$( cat  ./.y );

        return;
    }
    getPriCs()
    {
        priCS=$( cat  ./.stChkSum ); 

        return;
    }
    cleanUp()
    {
        rm ./.stChkSum;
        rm ./.y;    
        echo $nCSC >> ./.stChkSum;    
        
        return 0;
    }
    p=${config[trackDir]};
    cd $p;
    
    verbose "starting comparison of $p" 3;
   
    prepareCheckSum;
    getNewCk;
    getPriCs;
    verbose "old $priCS" 3;
    verbose "nw $nCSC" 3;
    doComparison;
    cleanUp;
   
    return;      
}
	

compareDir;



