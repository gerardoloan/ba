. $commandPath/database/back-up-sql.sh;
gD=${config[gitDir]};

cd $gD;
verbose "committing in git dir $gD" 1;

git commit  -a -m "automated commit";

