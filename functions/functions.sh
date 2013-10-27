recLim()
{
    echo attemptRec;
    if [ ! "$recCount" -gt "$1" ]; then
        echo recurred;
        recCount=$(( recCount++ ));
        export recCount;
    else
        echo recedTolimit
        
    fi;
}
removeAnnoyingSymbols()
{ 
   h;exit;
   ${$1%~}
   badname=echo "filename.sh" | sed -n /[\?~$]/p
  # + { ; " \ = ? ~ ( ) < > & * | $
}
 
recursiveFileCB()
{   
    for file in $( find  $1  ); do
        $2 $file;
    done;

    return;
}
recursiveExFileCB()
{
    for file in $( find  $1 -executable ); do
        $2 $file;
    done;

    return;
}

contextValidate()
{
    verbose "must validate $1 first" 3;
    . $commandPath/../config-validation/$1.sh;

    return;
}
isGitDir()
{
    if [ ! -d "$1" ]; then
        echo 1;
        
        return;
    fi;
    cd $1;
    
    stat=$(git status);
    if [[ "$?">"0" ]]; then
        echo 1;
        
        return;
    fi
    echo 0;
    
    return;
}
changeDbBackupFormat()
{

    format="sql";
    read -p 'sql || xml - 1 || 2 : ' changeFromSql;

    if [ "$changeFromSql" = "2" ]; then
        format="xml";
    fi

    return;
}

doGeneralCheck()
{
    doWelcome;
    warnBuild;
    validateConfig;
}


initSection()
{

    local section;
    section="$1";
    ls $projectCommandsPath/app/commands/$section;

    return;   
}

doWelcome()
{   
    welcome()
    {
        verbose 'welcome '$1 1;
    }
    warn()
    {
        if [ "$1" = "root" ]; then 
            verbose 'seems you are ROOT' 1;
    
            read -p 'EXIT 0 : 1 > ' bailOut;
            if [ "$bailOut" = "1" ]; then 
                verbose 'exiting ...';
                exit;
            fi
        fi
    }

    local user=$(whoami);
    
    welcome "$user";
    warn "$user";
}

warn()
{
    echo "$1" 1;
}



validateConfig()
{    
    for file in $projectCommandsPath/app/config-validation/*; do 
        if [ -e "$file" ] ; then        
        verbose "validator file $file" 3;
        verbose "Make sure it isn't an empty match" 4; 
          . "$file";
        fi;
    done;
}

warnBuild()
{   
    count=0;
    mode=${config[nonStrictMode]};
    if [[ $mode && "$mode"="1" ]]; then
        
        return;
    fi;
    #count files in dangerous dir
    for file in $projectCommandsPath/app/dangerous/*; do
        if [ -e "$file" ]; then
            ((count++));
        fi;
    done;
    #Limit is one. Strict mode throws error
    if [[ "$count" -gt "1" ]]; then
        error "to many files in $projectCommandsPath/app/dangerous";
    fi;
}

exitOnError()
{
    #error status must not be greater than 0;
    if [[ "$1">"0" ]]; then
        #message
        echo $2;
        exit;
    fi
}
##############################################
# start the tasks

#startBGProc()
#{
#    sTO=${config[saveTimeOut]};
 #   while true do
 #       sleep $sTO;
   #    compareDirStatusRecordsEqual;
  # done
#}
checkProcesses()
{
    return;
}


doAction()
{
    if [[ "$1"='save' ]]; then
        dir=$dir'save' 
        cd $dir;
        for entry in "${saveConfig[@]}";  do
            . $entry ;
        done;
    fi
}

#########################################################################################
makeSecure()
{
    makeSecretFile()
    {
        echo ${config[@]} >>  ${config[secretBackUp]};
        verbose 'why is it secret' 4;        
    }
    makeSecretFile;
    doOpenSecret()
    {
        doSecret()
        {
            tar czvf - "$1" |
            openssl des3 -salt -out "$2" -pass pass:"$3";
        }
        mvSecret()
        {
            cd "$1";
            git add .;
            git push secret;
        }
        g=${config[openSecret]}
        l=${config[openSecretLocation]};
        p=${config[openSecretPswd]};
        o=${config[openSecret]}
        r=${config[openSecretRemote]};

        isG=$( isDirGit $g );

        if [[ "$l" && "$o" && "$p" && ! "$isG" = "1" ]]; then
            verbose 'moving secrets to [[ "$l" && "$o" && "$p" ]]' 3; 
            doSecret "$l" "$o" "$p";
            mvSecret "$g";
            return;
        fi;
    }
}
