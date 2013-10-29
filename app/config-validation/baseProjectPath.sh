bPP=${config[baseProjectPath]};

if [ !  $bPP ];then
   error '***ERROR*** baseProjectPath not set '.$bPP;
fi
if [ ! -d $bPP ];then
   error '***ERROR*** baseProjectPath not directory '.$bPP;
fi
if [ ! -w $baseProjectPath ];then
   error '***ERROR*** baseProjectPath not writeable'.$bPP;
fi
