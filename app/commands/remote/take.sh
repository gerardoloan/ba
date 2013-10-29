u=${config[remoteUser]};
h=${config[remoteHost]};

tD={config[trackDir]};
verbose "taking the tracking dir cp of $tD" 1;
scp -r -i ~/.ssh/id_rsa.pub $u@$h:~/$tD ~/$tD;

r=${config[remoteDbBackupDir]};
verbose "taking the db dumb from $r" 1;
scp -i ~/.ssh/id_rsa.pub $u@$h:~/$r/recent.sql ~/$r/recent.sql;
