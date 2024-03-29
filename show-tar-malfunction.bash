#!/data/data/com.termux/files/usr/bin/bash
TERMUX_VERSION=0.118.0
#tar --version
#tar (GNU tar) 1.35
#Copyright (C) 2023 Free Software Foundation, Inc.
#License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.
#This is free software: you are free to change and redistribute it.
#There is NO WARRANTY, to the extent permitted by law.
#
#Written by John Gilmore and Jay Fenlason.
# this script is mostly an exersize to test out all of the functionality of gnu tar and is paired with snapshot-update.bash 
# a script to combine the exersizes into a single script without user input and show a tar malfunction 
level=0
#echo "Input directory name to create and target for archiveing: "
#read target
target=testdir
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
#second part shows .snar not changed
echo 'A new file' > $target/Anewfile.txt
echo "updating $target "
#read target
#echo 'Enter level (0 or 1): '
#read level
level=1
echo $level
#mkdir $target
#touch $target/EXCLUDE.LST
#echo "EXCLUDE.LST list's patterns ofwhich when found within the directory thereof are excluded from tar snapshots." > $target/readme.txt
#touch $target/EXCLUDER.LST
#echo "EXCLUDER.LST list's patterns ofwhich when found within the directory thereof and any subdirectories are excluded from tar snapshots." >> $target/readme.txt
#mkdir $target/cache
#touch $target/cache/CACHEDIR.TAG
#mkdir $target/include
#touch $target/include/EXCLUDEC.TAG
#echo 'Contents of any directory containing EXCLUDEC.TAG are excluded from tar snapshots.' > $target/include/readme.txt
#mkdir $target/include/excluded
#touch $target/include/excluded/EXCLUDED.TAG
#echo 'Any directory containing EXCLUDED.TAG and the contents thereof are excluded from tar snapshots.' > $target/include/excluded/readme.txt
#mkdir $target/include1
#mkdir $target/include1/excludeA
#mkdir $target/include1/excludeA/exclude1
#mkdir $target/include1/excludeA/exclude2
#mkdir $target/include1/excludeA/exclude3
#mkdir $target/include1/excludeB
#mkdir $target/include1/excludeB/exclude1
#mkdir $target/include1/excludeB/exclude2
#mkdir $target/include1/excludeB/exclude3
#echo 'Any subdirectory of the directory containing EXCLUDES.TAG excluded from tar snapshots.' > $target/include1/readme.txt

tar --update --preserve-permissions --acls --selinux --xattrs --backup=numbered --exclude-backups --exclude-caches --exclude-ignore=EXCLUDE.LST --exclude-ignore-recursive=EXCLUDER.LST --exclude-tag-under=EXCLUDES.TAG \
           --file=$target.$level.tar \
           --level=$level --listed-incremental=$target.snar \
           $target
echo "Showing malfunction."
cat $target.snar
echo "Grep for Anewfile.txt in the .snar"
grep Anewfile.txt $target.snar

