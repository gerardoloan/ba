
declare -A config;
declare -A saveConfig;
declare -a saveConfigHandlers;
#-A option declares associative array.

saveConfig[0]='back-up-db';
saveConfig[1]='move-to-remote';


config[saveFreq]=10;
config[remoteDbDir]='/data/remote/db';
config[baseConfigFile]='/usr/bin/project-commands/config/config.sh';

config[quickReportFile]='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com/module';
# dir to put a 
config[quickViewDir]="/home/gerard/sitesinfo/working/"
# file to put the report in
config[pageDocReportFile]="/home/gerard/sitesinfo/working/report.xml"
#root git dir
config[gitDir]='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com' ;
# dir used to create doc from
config[apigenDir]='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com/module/ZfModule';
#a test dir to look 
config[testDir]='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com/module/ZfModule/test';
#current tracking directory
config[trackDir]='/home/gerard/cl/project-commands';
config[db]='moduleswdoctrine';
config[dbUser]='root';
config[dbPassword]='fuckit2004';
config[dbBackupDir]='/home/gerard/db';
#not base path
config[remoteDbBackupDir]='data/remote/db';

config[baseProjectPath]='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com';
config[sysVerbosity]='3';


###################################################################


