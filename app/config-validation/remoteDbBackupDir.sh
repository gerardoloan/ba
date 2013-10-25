# validate $remoteDbBackupDir dir write

# contextValidate 'baseProjectPath' ${config[baseProjectPath]};
bPP=${config[baseProjectPath]};

#vailadte we have short path
if [ ! $bPP ];then
   error '***ERROR*** remote db back up not declared';
fi

#create full path
rDBBD=${config[remoteDbBackupDir]};
dir=$bPP/$rDBBD;

#validate 
if [ ! -d $dir ];then
     error "***ERROR*** -d remoteDbBackupDir $Dir";
fi
echo $remoteDbBackupDir;
if [ ! -w $dir ];then
   error "***ERROR*** -w remoteDbBackupDir $Dir";
fi

