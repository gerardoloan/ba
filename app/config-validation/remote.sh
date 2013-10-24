# validate $remoteDbBackupDir dir write
r=${config[remoteDbDir]};

db=${config[db]};
proPath=${config[baseProjectPath]};
fp=$proPath$r/$db;  

if [ ! -d "$fp" ];then
    error $fp' not dir';    
fi

#vailadte we have short path
if [ ! $r ];then
   error '***ERROR*** remote db back up not declared'$r;
fi

#create full path
b=${config[baseProjectPath]};
# $r remote path
dir=$b$r;

#validate  write and dir 
if [ ! -d $dir ];then
   error '***ERROR*** -d remoteDbBackupDir '.$dir;
fi

if [ ! -w $dir ];then
   error '***ERROR*** -w $remoteDbBackupDir '.$dir;
fi

