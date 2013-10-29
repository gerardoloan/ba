
. $commandPath/git/commitWithDb.sh;
gD=${config[gitDir]};
g=${config[remoteGitName]};

if [ ! "$g" ]; then
    g=github;
fi;

cd $gD;
verbose "push to github in git dir $gD" 1;

git push $g;
