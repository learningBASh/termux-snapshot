#!/data/data/com.termux/files/usr/bin/bash
# this script is mostly annexersize to test out all ofvthe functionality of gnu tar and is paired with snapshot-update.bash 
level=0
echo "Input directory name to create and target for archiveing: "
read target
mkdir $target
touch $target/EXCLUDE.LST
echo "EXCLUDE.LST list's patterns ofwhich when found within the directory thereof are excluded from tar snapshots." > $target/readme.txt
touch $target/EXCLUDER.LST
echo "EXCLUDER.LST list's patterns ofwhich when found within the directory thereof and any subdirectories are excluded from tar snapshots." >> $target/readme.txt
mkdir $target/cache
touch $target/cache/CACHEDIR.TAG
mkdir $target/include
touch $target/include/EXCLUDEC.TAG
echo 'Contents of any directory containing EXCLUDEC.TAG are excluded from tar snapshots.' > $target/include/readme.txt
mkdir $target/include/excluded
touch $target/include/excluded/EXCLUDED.TAG
echo 'Any directory containing EXCLUDED.TAG and the contents thereof are excluded from tar snapshots.' > $target/include/excluded/readme.txt
mkdir $target/include1
mkdir $target/include1/excludeA
mkdir $target/include1/excludeA/exclude1
mkdir $target/include1/excludeA/exclude2
mkdir $target/include1/excludeA/exclude3
mkdir $target/include1/excludeB
mkdir $target/include1/excludeB/exclude1
mkdir $target/include1/excludeB/exclude2
mkdir $target/include1/excludeB/exclude3
echo 'Any subdirectory of the directory containing EXCLUDES.TAG excluded from tar snapshots.' > $target/include1/readme.txt

tar --create --preserve-permissions --acls --selinux --xattrs --backup=numbered --exclude-backups --exclude-caches --exclude-ignore=EXCLUDE.LST --exclude-ignore-recursive=EXCLUDER.LST --exclude-tag-under=EXCLUDES.TAG \
           --file=$target.0.tar \
           --level=$level --listed-incremental=$target.snar \
           $target
