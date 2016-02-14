## Local:

Install git and clone this repository into `~/Sites`.

Follow [this guide](https://gorails.com/setup/osx/10.10-yosemite) to install Rails on Mac or [this guide](https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04) for Linux.

`cd` into this directory

`bundle exec rake db:migrate` to set up your database

`bundle exec rails s` to start the server.

Go to [localhost](http://localhost:3000/routes) to view the application.

## Vagrant:

[Linux](http://www.olindata.com/blog/2014/07/installing-vagrant-and-virtual-box-ubuntu-1404-lts) / [Mac](http://sourabhbajaj.com/mac-setup/Vagrant/README.html).  Make sure to use "ubuntu/trusty64" as the box image instead of "precise64", "precise32", or whatever else they say.

Install [Chef](https://downloads.chef.io/chef-dk/)

`vagrant plugin install vagrant-berkshelf`

`vagrant plugin install vagrant-omnibus`

`berks install`

Mac:

`sudo echo '10.11.12.13 local.sendero.com' > /etc/hosts`

Linux:

`echo '10.11.12.13 local.sendero.com' | sudo tee --append /etc/hosts > /dev/null`

`export PATH="/opt/chefdk/bin:$PATH"`

Linux only: `sudo apt-get install nfs-kernel-server`

`vagrant up` in the project directory.  This will take a while to download the box template and install all the programs.

`ssh vagrant@10.11.12.13` - password is 'vagrant'

`nano ~/.ssh/authorized_keys` and add your public key (found in ~/.ssh/id_rsa.pub in your host computer).  If you don't have a public key, [create one](https://help.github.com/articles/generating-a-new-ssh-key/).  Save the file and exit.  You should now be able to ssh into the machine with `vagrant ssh` and not have to use a password.

`vagrant ssh`

`bundle exec rails s` - This will start the server and you can access the application [locally](http://local.sendero.com)