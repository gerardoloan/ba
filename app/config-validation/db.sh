
#validate set
db=${config[db]};
dbUser=${config[dbUser]};
dbPassword=${config[dbPassword]};
dbBackupDir=${config[dbBackupDir]};
remoteDbBackupDir=${config[remoteBackupDir]};


if [[ ! $db || ! $dbUser || ! $dbPassword ]]; then
   error '***ERROR***  required db info not set';
fi

# validate $dbBackupDir dir write
if [ !  $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir not set '.$dbBackupDir;
fi
if [ ! -d $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir not directory '.$dbBackupDir;
fi
if [ ! -w $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir not writeable'.$dbBackupDir;
fi
g=$( isGitDir $dbBackupDir ); 
if [[ "$g">"0" ]]; then
   error "***ERROR***  dbBackupDir:  $dbBackupDir is not  a git returned $?";   
fi

verbose 'db config exists' 2;
verbose 'testing connection ...' 2;

    e=$(mysqlshow --version -u $dbUser -p$dbPassword $db);
    if [[ "$?" > 0 ]]; then
        error '***ERROR*** mysqlshow not responding properly';
        return;
    fi  
    
    return


verbose 'connection tried' 2;
