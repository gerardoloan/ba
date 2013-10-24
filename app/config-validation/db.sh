
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




printConfigValidation 'db config exists'
printConfigValidation 'testing connection ...'
handleVerboseDb()
{
    if [[ $verbose > 1 ]]; then
        mysqlshowResult= mysqlshow --version -u $dbUser -p$dbPassword $db;
        
        return;
    fi
    
    mysqlshow --version -u $dbUser -p$dbPassword $db;

    return

}
handleVerboseDb

printConfigValidation 'connection tried';
