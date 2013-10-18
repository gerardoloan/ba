#assert $quickViewDir dir read
quickViewDir=${config[quickViewDir]};

if [ ! -d $quickViewDir ]; then
    error "***ERROR*** dir: $quickViewDir is not valid dir";

fi
if [ ! -r $quickViewDir ]; then
    error "***ERROR*** dir: $quickViewDir is not writable valid dir";
fi

printConfigValidation  '$quickViewDir set : '$quickViewDir 1 $verbosity;