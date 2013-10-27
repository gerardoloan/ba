#. $projectCommandsPath/functions/remote-manager;
proPath=${config[baseProjectPath]};

addDbDump()
{
    db=${config[db]};
    u=${config[dbUser]};
    p=${config[dbPassword]};
    r=${config[remoteDbBackupDir]};
    fp=$proPath/$r/$db;

    mysqldump -u $u -p$p -r $fp/$(date +%Y%m%d%h%m%s).sql $db;
    verbose "backup created at: " 1;
    verbose "$fp/$(date +%Y%m%d%h%m%s).sql" 1;

    return;
}

scpP()
{
    #tracking tracking directory
    td=${config[trackDir]};
    verbose "recursive copy to remote" 3;		
    cp -r -f $td '/tmp/cl';
  
    return;    
}

echo inmaaee;	
verbose "manage remote knows $projectDirChanged";
if [ -f "/var/tmp/space-tool/comDirFalse" ]; then
    verbose "managing remote" 3;
    addDbDump;
    scpP;
fi;
