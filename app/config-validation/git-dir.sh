
g=${config[gitDir]};
cd $g;
eat=0;
eat=$(isGitDir $g);
if [ "$eat" -gt "0" ]; then
   error "***ERROR***  git status error:  $g";   
fi


