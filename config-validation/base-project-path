baseProjectPath=${config[baseProjectPath]};

if [ !  $baseProjectPath ];then
   error '***ERROR*** $dbBackupDir not set '.$dbBackupDir;
fi
if [ ! -d $baseProjectPath ];then
   error '***ERROR*** $dbBackupDir not directory '.$dbBackupDir;
fi
if [ ! -w $baseProjectPath ];then
   error '***ERROR*** $dbBackupDir not writeable'.$dbBackupDir;
fi