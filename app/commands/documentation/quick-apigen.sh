
quickViewDir=${config[quickViewDir]};
s=${config[quickReport]};
d=${config[quickViewDir]};
report=${config[quickReportFile]};

apigen -s $s -d $d --report $report --todo --deprecated --debug 
