
gitDir=${config[gitDir]};
if [ ! -d $gitDir/.git ]; then
   error "***ERROR***  dir:  $gitDir is not  a git";
   
fi

handleVerbose()
{
    if [[ $verbosity > 1 ]]; then
        printConfigValidation 'ls '$gitDir/.git  1 $verbosity;
        ls $gitDir/.git;
        
        return;
    fi

    printConfigValidation  '$gitDir set : '$gitDir 1 $verbosity;
    
    return;
}


handleVerbose;