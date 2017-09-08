####**Linux Ubuntu 16.04 LTS**

---
```
sudo su root
rm -rf /var/lib/dpkg/lock
apt-get update
apt-get install -f
apt autoremove
```
##### Install Ruby
```
apt-add-repository ppa:brightbox/ruby-ng &&\
apt update &&\
apt install autoconf bison build-essential &&\
libxml2-dev libssl-dev libyaml-dev &&\
libreadline6-dev zlib1g-dev libncurses5-dev &&\
libffi-dev libgdbm3 libgdbm-dev &&\
sqlite3 libsqlite3-dev &&\
ruby2.4 ruby2.4-dev
```
##### Install Ruby on Rails
```
gem install bundler:1.15.3 rails:5.1.2 --no-ri --no-rdoc
```
##### Install NodeJS & NPM
```
apt install curl &&\
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - &&\
apt update &&\
apt install -y nodejs=6.11.*
```
##### Configuration GIT
```
git config --global user.name "Nurasyl Aldan" &&\
git config --global user.email "nurassyl.aldan@gmail.com" &&\
git config user.name &&\
git config user.email
```
##### Install PostgreSQL
```
touch /etc/apt/sources.list.d/pgdg.list && echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" >> /etc/apt/sources.list.d/pgdg.list wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \ apt-key add - apt-get update && apt-get install postgresql-9.6 libpq-dev pgadmin3
```
##### Create database in PostgreSQL
```
sudo su postgres
psql
CREATE USER nurasyl WITH PASSWORD '12345';
ALTER ROLE nurasyl SET client_encoding TO 'utf8';
ALTER ROLE nurasyl SET default_transaction_isolation TO 'SERIALIZABLE';
ALTER ROLE nurasyl SET timezone TO 'UTC';
CREATE DATABASE seven_note;
CREATE DATABASE seven_note_test;
CREATE DATABASE seven_note_dev;
GRANT ALL PRIVILEGES ON DATABASE seven_note, seven_note_test, seven_note_dev TO nurasyl;
\du
\q
psql -d app1 -U nurasyl -h 127.0.0.1 -p 5432
\c
\q
exit
```
##### Create database in RoR
```
rake db:drop:all
rake db:create:all
```
##### Migrate
```
rake db:seed RAILS_ENV=test &&\
rake db:migrate RAILS_ENV=test

rake db:seed RAILS_ENV=development &&\
rake db:migrate RAILS_ENV=development
```
##### Install redis
```
wget http://download.redis.io/releases/redis-4.0.1.tar.gz
tar xzf redis-4.0.1.tar.gz
cd redis-4.0.1
make
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/
```
##### Git commit
```
git reset && git rm -r --cached . && git reset && git add --all && git commit -m "My comment" && git push origin master
```
##### Save in development
```
git checkout dev && sudo chmod 777 save.sh && ./save.sh
```
##### NPM install.
```
npm install
```
##### Install font awesome.
```
rm -f font-awesome-4.7.0.zip &&\
rm -rf font-awesome-4.7.0 &&\
wget http://fontawesome.io/assets/font-awesome-4.7.0.zip &&\
unzip font-awesome-4.7.0.zip &&\
rm font-awesome-4.7.0.zip &&\
mv -f font-awesome-4.7.0/css/font-awesome.min.css public/css/lib/font-awesome.css &&\
mv -f font-awesome-4.7.0/fonts/* public/css/fonts &&\
rm -r font-awesome-4.7.0
```
##### Install bootstrap 3.
```
rm -f bootstrap-3.3.7-dist.zip &&\
rm -rf bootstrap-3.3.7-dist &&\
wget https://github.com/twbs/bootstrap/releases/download/v3.3.7/bootstrap-3.3.7-dist.zip &&\
unzip bootstrap-3.3.7-dist.zip &&\
rm bootstrap-3.3.7-dist.zip &&\
mv -f bootstrap-3.3.7-dist/css/bootstrap.min.css public/css/lib/bootstrap.css &&\
mv -f bootstrap-3.3.7-dist/css/bootstrap-theme.min.css public/css/lib/bootstrap-theme.css &&\
mv -f bootstrap-3.3.7-dist/js/bootstrap.js public/js/lib/bootstrap.js &&\
mv -f bootstrap-3.3.7-dist/fonts/* public/css/fonts &&\
rm -r bootstrap-3.3.7-dist
```
##### Install bootstrap 4.
```
wget https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css &&\
mv -f bootstrap.min.css public/css/lib/bootstrap.css &&\

wget https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js &&\
mv -f popper.min.js public/js/lib/popper.js &&\

wget https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js &&\
mv -f bootstrap.min.js public/js/lib/bootstrap.js
```
##### Install bootstrap datepicker.
```
rm -rf bootstrap-datepicker &&\
mkdir bootstrap-datepicker &&\
cd bootstrap-datepicker &&\
wget https://github.com/uxsolutions/bootstrap-datepicker/releases/download/v1.6.4/bootstrap-datepicker-1.6.4-dist.zip &&\
unzip bootstrap-datepicker-1.6.4-dist.zip &&\
rm bootstrap-datepicker-1.6.4-dist.zip &&\
cd ../ &&\
mv -f bootstrap-datepicker/js/bootstrap-datepicker.min.js public/js/lib/bootstrap-datepicker.js &&\
mv -f bootstrap-datepicker/css/bootstrap-datepicker.min.css public/css/lib/bootstrap-datepicker.css &&\
mv -f bootstrap-datepicker/css/bootstrap-datepicker.standalone.min.css public/css/lib/bootstrap-datepicker.standalone.css &&\
mv -f bootstrap-datepicker/locales/bootstrap-datepicker.en-AU.min.js public/js/lib/bootstrap-datepicker.en-AU.js
rm -rf bootstrap-datepicker
```
##### Install AngularJS.
```
wget https://ajax.googleapis.com/ajax/libs/angularjs/1.6.5/angular.min.js &&\
mv -f angular.min.js public/js/lib/angular.js &&\

wget http://ajax.googleapis.com/ajax/libs/angularjs/1.6.5/angular-route.min.js &&\
mv -f angular-route.min.js public/js/lib/angular-route.js  &&\

wget http://ajax.googleapis.com/ajax/libs/angularjs/1.6.5/angular-cookies.min.js &&\
mv -f angular-cookies.min.js public/js/lib/angular-cookies.js  &&\

wget http://ajax.googleapis.com/ajax/libs/angularjs/1.6.5/angular-sanitize.min.js &&\
mv -f angular-sanitize.min.js public/js/lib/angular-sanitize.js
```
##### Install UnderscoreJS and Normalize-CSS.
```
wget http://underscorejs.org/underscore-min.js &&\
mv -f underscore-min.js public/js/lib/underscore.js &&\

wget https://necolas.github.io/normalize.css/7.0.0/normalize.css &&\
mv -f normalize.css public/css/lib/normalize.css
```
##### Install jQuery.
```
wget https://code.jquery.com/jquery-3.2.1.min.js &&\
mv -f jquery-3.2.1.min.js public/js/lib/jquery.js &&\

wget https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js &&\
mv -f jquery.cookie.min.js public/js/lib/jquery.cookie.js
```
##### Install bootbox.
```
wget https://cdnjs.cloudflare.com/ajax/libs/bootbox.js/4.4.0/bootbox.min.js &&\
mv -f bootbox.min.js public/js/lib/bootbox.js
```
##### Run redis server
```
redis-server ./redis.conf
```
##### Install gems.
```
bundle install
bundle update
```
##### Test
```
bundle exec rake
bundle exec rspec
```
##### Run RoR server
```
rails s
```
