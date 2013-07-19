#!/bin/bash

cd ~/
echo "======================================================="
echo "System Updates"
echo "======================================================="
#
sudo apt-get -y update

echo "======================================================="
echo " Extra Packages"
echo "======================================================="
sudo apt-get install -y make g++ curl git-core python-software-properties
sudo apt-get install -y build-essential zlib1g-dev libyaml-dev libssl-dev
sudo apt-get install -y libgdbm-dev libreadline6-dev libncurses5-dev
sudo apt-get install -y libpq-dev libffi-dev 

# get and install OpenSSL
cd ~/
echo "======================================================="
echo "Installing Openssl"
echo "======================================================="
wget http://www.openssl.org/source/openssl-1.0.1e.tar.gz 
tar zxvf openssl-1.0.1e.tar.gz
cd openssl-1.0.1e/
./config
make
sudo make install
sudo update-alternatives --install /usr/bin/openssl openssl /usr/local/ssl/bin/openssl 1 --force

# Install system-wide ruby 2.0.0-p247
cd ~/
echo "======================================================="
echo "Installing ruby"
echo "======================================================="
wget http://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.gz
tar zxvf ruby-2.0.0-p247.tar.gz
cd ruby-2.0.0-p247/
./configure
make
sudo make install
echo "======================================================="
echo "Installing ruby-gems"
echo "======================================================="
wget http://production.cf.rubygems.org/rubygems/rubygems-2.0.4.tgz
tar zxvf rubygems-2.0.4.tgz
cd rubygems-2.0.4/
sudo /usr/local/bin/ruby setup.rb
sudo gem install bundler --no-ri --no-rdoc

# nginx
cd ~/
echo "======================================================="
echo "Installing nginx"
echo "======================================================="
sudo add-apt-repository ppa:nginx/stable
sudo apt-get -y update
sudo apt-get -y install nginx
sudo service nginx start
# it works

# PostgreSQL
echo "======================================================="
echo "Installing postgresql"
echo "======================================================="
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main"  > pgdg.list
sudo mv pgdg.list /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install postgresql-common -t raring
sudo apt-get -y install postgresql-9.2
psql --version
#sudo -u postgres psql
# \password
# create user blog with password 'secret';
# create database blog_production owner blog;
# \q

# Postfix
echo "======================================================="
echo "Installing postfix"
echo "======================================================="
sudo apt-get -y install telnet postfix

# Node.js
echo "======================================================="
echo "Installing node.js"
echo "======================================================="
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs

# Add deploy user
echo "======================================================="
echo "Adding deploy user"
echo "======================================================="
sudo adduser deploy --ingroup admin
# su - deploy
# ssh git@github.com
# sudo mkdir ~deploy/.ssh
# sudo vi ~deploy/.ssh/authorized_keys


# After cap deploy:setup
# vi apps/blog/shared/config/database.yml
# just leave production in there with the passwd

# After cap deploy:cold
# sudo rm /etc/nginx/sites-enabled/default
# sudo service nginx restart
# sudo update-rc.d unicorn_blog defaults

# Cleanup
echo "======================================================="
echo "Cleaning up Build Directories"
echo "======================================================="
cd ~/
rm -fr openssl-1.0.1e openssl-1.0.1e.tar.gz
rm -fr ruby-2.0.0-p247 ruby-2.0.0-p247.tar.gz
rm -fr rubygems-2.0.4 rubygems-2.0.4.tgz

# install a bunch of gems
echo "======================================================="
echo "Installing gems"
echo "======================================================="
sudo gem install rake
sudo gem install  rails
sudo gem install  pg
sudo gem install  sass-rails
sudo gem install  uglifier
sudo gem install  coffee-rails
sudo gem install  therubyracer
sudo gem install  jquery-rails
sudo gem install  turbolinks
sudo gem install  jbuilder
sudo gem install  unicorn
