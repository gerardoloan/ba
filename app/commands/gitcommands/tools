echo 'gitg : 1'
echo 'git-cola : 2'
echo 'giggle : 3'

read -p 'select tool : (int)' tool

gitDir=${config[gitDir]}
if [ "$tool" = "1" ]; then
    tool="gitg";
fi

if [ "$tool" = "2" ]; then
    tool="git-cola";
fi

if [ "$tool" = "3" ]; then
    tool="giggle";
fi

cd $gitDir;
$tool