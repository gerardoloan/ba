
#validate set
db=${config[db]};
dbUser=${config[dbUser]};
dbPassword=${config[dbPassword]};
dbBackupDir=${config[dbBackupDir]};
if [[ ! $db || ! $dbUser || ! $dbPassword ]]; then
   error '***ERROR***  required db info not set';
fi

# validate $dbBackupDir dir write
if [ ! -d $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir '.$dbBackupDir;
fi
if [ ! -w $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir not writeable'.$dbBackupDir;
fi
if [ !  $dbBackupDir ];then
   error '***ERROR*** $dbBackupDir not set '.$dbBackupDir;
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
