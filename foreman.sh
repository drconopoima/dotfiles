# 
# Installs and configures all in one foreman server on ubuntu precise
#


echo "Changing passwd for root"
passwd
apt-get update && apt-get upgrade
reboot
echo -n "Enter default user name: "
read username
useradd -m $username
passwd $username
usermod -G sudo $username
echo "deb http://deb.theforeman.org/ precise stable" > /etc/apt/sources.list.d/foreman.list
wget -q http://deb.theforeman.org/foreman.asc -O- | apt-key add -
apt-get update && apt-get install foreman-installer

# Hack depends on the ipv4 addr being the second line of host file
ip=`head -2 /etc/hosts|tail -1|awk '{print $1}'
sed -i '' -e "s/$ip/$ip foreman.onemanops.com /"

echo "foreman.onemanops.com" > /etc/hostname
hostname `cat /etc/hostname`

ruby /usr/share/foreman-installer/generate_answers.rb 

