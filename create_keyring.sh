./ceph-authtool --create-keyring ./ceph.client.radosgw.keyring
chmod +r ./ceph.client.radosgw.keyring
./ceph-authtool ./ceph.client.radosgw.keyring -n client.radosgw.gateway --gen-key
./ceph-authtool -n client.radosgw.gateway --cap osd 'allow rwx' --cap mon 'allow rwx' ./ceph.client.radosgw.keyring
./ceph -k ./keyring auth add client.radosgw.gateway -i ./ceph.client.radosgw.keyring
