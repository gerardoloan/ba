

read -p "source " s
read -p "destination " d
read -p  "report " r

read -p  "use google-analytics ? 0 : 1 "  useGa

if [ "$useGa" = "1" ]; then
    read -p  "google-analytics tracking code "  ga
    apigen -s $s -d $d  --report $r  --google-analytics $ga  --access-levels "public,protected,private" --download  --debug

else
    apigen -s $s -d $d  --report $r  --access-levels "public,protected,private" --download  --debug 
fi