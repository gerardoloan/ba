# validate $remoteDbBackupDir dir write
if [ ! $remoteDbBackupDir ];then
   error '***ERROR*** remote db back up not declared';
fi
if [ ! -d $remoteDbBackupDir ];then
   error '***ERROR*** $remoteDbBackupDir '.$remoteDbBackupDir;
fi
echo $remoteDbBackupDir;
if [ ! -w $remoteDbBackupDir ];then
   error '***ERROR*** $remoteDbBackupDir not writeable'.$remoteDbBackupDir;
fi
here;exit