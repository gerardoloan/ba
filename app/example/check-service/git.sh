isGitDir()
{
    if [ ! -d "$1" ]; then
        echo 1;
    fi;
    cd $1;
    stat=$(git status);
    if [[ "$?">"0" ]]; then
        echo 1;
    fi
}
dir='/home/gerard/sites/modules.w.doctrine/modules.zendframework.com';
isGitDir $dir;
