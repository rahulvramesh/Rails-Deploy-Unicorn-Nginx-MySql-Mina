sudo apt-get update

sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

##Setup Git
git config --global color.ui true
git config --global user.name "YOUR NAME"
git config --global user.email "YOUR@EMAIL.com"

##Installing Ruby 2.3.1 Using rbenv

cd
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

rbenv install 2.3.1
rbenv global 2.3.1
ruby -v

##Installing Bundle

gem install bundler

##Installing Node

curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs

#Installing Rails

gem install rails


rbenv rehash

#MYSQL Install

sudo apt-get install mysql-server mysql-client libmysqlclient-dev


# OR POSTGREES

sudo sh -c "echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install postgresql-common
sudo apt-get install postgresql-9.5 libpq-dev

sudo -u postgres createuser chris -s

# If you would like to set a password for the user, you can do the following
sudo -u postgres psql
postgres=# \password chris

#Nginx
sudo apt-get install nginx


#unicorn
	
gem install unicorn

#Create Shared Folder

cd example
	
mkdir -p shared/pids shared/sockets shared/log

#Adding Reverse Proxy To Nginx (Do Nothing)
/etc/nginx/nginx.conf


#Setup Virtual Host
/etc/nginx/sites-available/example

upstream unicorn {
  server unix:/home/ubuntu/example/shared/sockets/unicorn.sock fail_timeout=0;
}

server {
  listen 80 default_server ;
  server_name localhost;
  root /home/ubuntu/example;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://unicorn;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 20M;
  keepalive_timeout 10;
}



#Setup Unicorn In Project
/home/username/example/config/unicorn.rb

root = "/home/ubuntu/example"
working_directory root
pid "#{root}/shared/pids/unicorn.pid""
stderr_path "#{root}/shared/log/unicorn.stderr.log"
stdout_path "#{root}/shared/log/unicorn.stdout.log"

listen "/home/ubuntu/example/shared/sockets/unicorn.sock"
worker_processes 2
timeout 30



#start unicorn manually

unicorn -c config/unicorn.rb -E development -D


	
unicorn -c config/unicorn.rb -E production -D



#to kill
sudo pkill unicorn



##EC2 REF.
http://askubuntu.com/questions/46424/adding-ssh-keys-to-authorized-keys

#SIMPLE Rails
https://gorails.com/setup/ubuntu/16.04

##Ref Proxy And Unicorn
https://www.linode.com/docs/websites/ror/use-unicorn-and-nginx-on-ubuntu-14-04

#for cap
https://coderwall.com/p/yz8cha/deploying-rails-app-using-nginx-unicorn-postgres-and-capistrano-to-digital-ocean
