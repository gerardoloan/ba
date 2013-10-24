#assert $quickViewDir dir read
qDir=${config[quickViewDir]};

if [ ! -d $qDir ]; then
    error "***ERROR*** dir: $qDir is not valid dir";

fi
if [ ! -r $qDir ]; then
    error "***ERROR*** dir: $qDir is not writable valid dir";
fi

verbose  '$quickViewDir set : '$qDir 2;
