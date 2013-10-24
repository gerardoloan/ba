# validate $remoteDbBackupDir dir write

remoteDbBackupDirSP=${config[baseProjectPath]};

#vailadte we have short path
if [ ! $remoteDbBackupDirSP ];then
   error '***ERROR*** remote db back up not declared';
fi

#create full path
baseProjectPath=${config[baseProjectPath]};
dir=$baseProjectPath$remoteDbBackupDirSP;

#validate 
if [ ! -d $dir ];then
   error '***ERROR*** -d remoteDbBackupDir '.$remoteDbBackupDir;
fi
echo $remoteDbBackupDir;
if [ ! -w $dir ];then
   error '***ERROR*** -w $remoteDbBackupDir '.$remoteDbBackupDir;
fi
