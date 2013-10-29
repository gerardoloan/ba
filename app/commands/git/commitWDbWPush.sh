verbose "doing a commit with a db dump" 1;
. $commandPath/git/commitWithDb.sh;
verbose "pushing to a remote" 1;
. $commandPath/git/pushGithub.sh;
