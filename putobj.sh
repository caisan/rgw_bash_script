for i in {1..32}
do
    for j in {1..10}
    do
        s3cmd -c s3cfg put "caisan"$j s3://"Test"$i
    done
done
