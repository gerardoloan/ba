compareDir()
{    
    doComparison()
    {
        if [ "$priCS" = "$nCSC" ]; then
            verbose 'workMore' 1;
           
            return 1;
        fi;

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
    echo enteringPorcessor;
    verbose "starting comparison of $p":
   
    prepareCheckSum;
    getNewCk;
    getPriCs;
    verbose "old $priCS" 3;
    verbose "nw $nCSC" 3;
    doComparison;
    cleanUp;
   
    return;      
}
echo dc;	
projectDirChanged="true";
compareDir;



