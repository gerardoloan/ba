db=${config[db]};
dbUser=${config[dbUser]};
dbPassword=${config[dbPassword]};
dbBackupDir=${config[dbBackupDir]};


read -p 'change db' changeDb
if [ $changeDb ]; then 
    read -p '$db = ' dbBackupDir ;
fi 
read -p 'change db user' changeDbUser;
if [[ $changeDbUser ]]; then
    read -p '$dbUser = ' dbUser;
fi 
read -p 'change db password' changeDbPw;
if [ $changeDbPw ]; then 
    read -p '$dbPassword = ' dbPassword;
fi 
read -p 'change db backup dir' changeDbDir;
if [ $changeDbDir ]; then 
    read -p '$dbBackupDir = ' dbBackupDir ;
fi 

. /usr/bin/project-commands/app/commands/database/back-up-xml


