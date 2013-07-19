rails new blog -d postgresql -T
cd blog
rails g scaffold article name content:text

vi .gitignore 
    /config/database.yml
cp config/database.yml config/database.example.yml

git init
git add .
git commit -m "first commit"
git remote add origin https://github.com/cyberrecon/blog.git
git push -u origin master

# Next setup capistrano
vi Gemfile
  gem 'unicorn'
  gem 'capistrano'
sudo bundle

rake db:migrate

# run capify . to setup capistrano in this application
capify .
vi Capfile 
vi config/deploy.rb  # paste in your capistrano recipe
vi config/nginx.conf # paste in code
vi config/unicorn.rb # paste in code
vi config/unicorn_init.sh # paste in code
chmod +x config/unicorn_init.sh

git add .
git commit -m " initial deploy config"
git push origin master
cap deploy:setup  # creates symlinks and dirs and uploads config/database.yml

# next log into the server and edit apps/blog/shared/config/database.yml
# just leave production in there with the passwd

# note I had to setup ssh keys for deploy user
cat ~/.ssh/id_rsa.pub | ssh deploy@10.28.57.96 'cat >> ~/.ssh/authorized_keys'
eval "$(ssh-agent)" # these two lines need to be run for prod to fetch 
ssh-add             # from github

cap deploy:cold    #  runs migrations and server start

ssh prod 
sudo rm /etc/nging/sites-enabled/default
sudo service nginx restart
sudo updte-rc.d unicorn_blog defaults

# commit change and deploy
cap deploy    # redeploy

