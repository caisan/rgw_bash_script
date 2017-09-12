for i in {0..31}
do
    echo "bl.$i"
    ./rados -p .rgw.bl listomapvals bl.$i
done
