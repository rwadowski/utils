#!/bin/bash
_P4MERGE_PATH="$1"
   
echo 'Unpacking p4merge'
mkdir -p /usr/local/lib/p4merge & tar xvf $_P4MERGE_PATH -C /usr/local/lib/p4merge --strip-components 1

echo 'Creating p4diff script'    
rm -f /usr/local/bin/p4diff
echo '#!/bin/sh' >> /usr/local/bin/p4diff
echo '[ $# -eq 7 ] && /usr/local/bin/p4merge "$2" "$PWD/$5"' >> /usr/local/bin/p4diff
chmod +x /usr/local/bin/p4diff

echo 'Creating symbolic link to p4 installation binary'
rm -f /usr/bin/p4merge
ln -s /usr/local/lib/p4merge/bin/p4merge /usr/bin/p4merge

echo 'Creating p4merge script'
rm -f /usr/local/bin/p4merge
echo '#!/bin/sh' >> /usr/local/bin/p4merge
echo '/usr/bin/p4merge $*' >> /usr/local/bin/p4merge
chmod +x /usr/local/bin/p4merge

if [ -f ~/.gitconfig ]
then
    echo 'Appending config to existing file'
else
    echo 'Creating .gitconfig'
    touch ~/.gitconfig
fi

echo '[mergetool "p4merge"]' >> ~/.gitconfig
echo 'cmd = p4merge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"' >> ~/.gitconfig
echo 'keepTemporaries = false' >> ~/.gitconfig
echo 'trustExitCode = false' >> ~/.gitconfig
echo 'keepBackup = false' >> ~/.gitconfig
echo '[diff]' >> ~/.gitconfig
echo 'external = p4diff' >> ~/.gitconfig
