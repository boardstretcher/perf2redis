# remotely run latest version of this script
# wget -O - https://github.com/boardstretcher/bash-redis/blob/master/install-arch.sh | bash

# installation on vanilla arch linux
# virtual machine provided by rackspace

if [[ $EUID -ne 0 ]]; then
echo "script must be run as root"
exit
fi

if [ ! -f /etc/arch-release ]; then
echo "must be run on arch linux"
exit
fi

pacman -Syu --noconfirm
pacman --noconfirm -S inetutils

rm /usr/bin/python
ln -s /usr/bin/python2 /usr/bin/python

wget http://nodejs.org/dist/v0.10.17/node-v0.10.17.tar.gz
wget http://redis.googlecode.com/files/redis-2.6.14.tar.gz

tar zxvf node-v0.10.17.tar.gz 
tar zxvf redis-2.6.14.tar.gz 

cd redis-2.6.14/src
make && make install && cd
redis-server &

cd node-v0.10.17
./configure
make && make install && cd

npm install -g redis-commander
redis-commander &

echo "you will want to reboot to apply system updates"
