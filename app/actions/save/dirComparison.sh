compareDir()
{    
    doComparison()
    {
        if [ "$priCS" = "$nCSC" ]; then
            verbose 'workMore' 1;
            verbose "i've done enough" 5;
            return 0;
        fi;

        verbose "never stop the revolution" 1;
    }
    prepareCheckSum()
    {
        nCS=$( ls -lRF | md5sum );
        echo $nCS >> ./.y;
    }
    getNewCk()
    {
        nCSC=$( cat  ./.y );
    }
    getPriCs()
    {
        priCS=$( cat  ./.stChkSum ); 
    }
    cleanUp()
    {
        rm ./.stChkSum;
        rm ./.y;    
        echo $nCSC >> ./.stChkSum;    
        return 0;
    }
     echo 1;
    p=${config[trackDir]};
    cd $p;
    
    verbose "starting comparison of $p":
   
    prepareCheckSum;
    getNewCk;
    getPriCs;
    verbose "old $priCS" 3;
    verbose "nw $nCSC" 3;
    doComparison;
    cleanUp;
    #@todo make this a feature       
}	
 
compareDir;
    
