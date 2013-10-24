
dbBackupDir=${config[dbBackupDir]};

if [ ! -d $dbBackupDir ]; then
   mkdir  $dbBackupDir/$db;
fi

#read -p 'sql || xml - 1 | 2 : ' changeFromSql
changeDbBackupFormat $changeFromSql;

. $commandPath/database/back-up-$format;

cd $dbBackupDir;
git add -f .;
git commit -m 'db commit';
