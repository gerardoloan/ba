generate_list ()
{
    echo "one 1 three"
}
echo 'Let "word" grab output of function';
echo 'then assign it to var : expect 1';
count=0;
for word in $(generate_list)
    do
        if [ $count -eq 1 ]; then
            if [[ $word =~ [[:digit:]] ]]; then
                goodWork=$word;
            fi;
        fi;
        ((count++));
    done

echo "$goodWork batman";

