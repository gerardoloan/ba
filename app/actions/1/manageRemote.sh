#. $projectCommandsPath/functions/remote-manager;
proPath=${config[baseProjectPath]};
echo mR;
addDbDumpToCurrentProject()
{
    db=${config[db]};
    u=${config[dbUser]};
    p=${config[dbPassword]};
    r=${config[remoteDbBackupDir]};
    fp=$proPath/$r/$db;

    mysqldump -u $u -p$p -r $fp/$(date +%Y%m%d%h%m%s).sql $db;
    verbose "backup created at: " 1;
    verbose "$fp/$(date +%Y%m%d%h%m%s).sql" 1;
}

scpCurrentProject()
{
    #tracking tracking directory
    td=${config[trackDir]};
    verbose "recursive copy to remote" 3;
    cp -r -f $td '/tmp/cl';
  
    return;    
}
if [ "$projectDirChanged" = "true" ]; then
    verbose "managing remote" 3;
    addDbDumpToCurrentProject;
    scpCurrentProject;
fi;
