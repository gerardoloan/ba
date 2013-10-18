db=${config[db]};
dbUser=${config[dbUser]};
dbPassword=${config[dbPassword]};
dbBackupDir=${config[dbBackupDir]};

mysqldump -u $dbUser -p$dbPassword -r $dbBackupDir/$db/$(date +%Y%m%d%h%m%s).xml $db;
echo "backup created at: ";
echo $dbBackupDir/$db/$(date +%Y%m%d%h%m%s).xml;
