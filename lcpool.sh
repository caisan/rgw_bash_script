for i in {0..31}
do 
    ./rados -p .rgw.lc listomapvals lc.$i
done
