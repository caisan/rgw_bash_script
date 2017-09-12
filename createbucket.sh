for i in {0..10}
do
    s3cmd -c s3cfg mb s3://Test$i
done
