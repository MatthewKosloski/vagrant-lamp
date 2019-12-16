# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

settings = YAML.load_file 'settings.yml'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    
    # Ubuntu 18.04 LTS
    config.vm.box = "ubuntu/bionic64"

    config.vm.provision "shell" do |s|
        s.path = "bootstrap.sh"
        s.args = [
            settings['site']['ip'],
            settings['site']['mysql_database'],
            settings['site']['mysql_username'],
            settings['site']['mysql_password'],
            settings['site']['wordpress_username'],
            settings['site']['wordpress_password'],
            settings['site']['wordpress_email'],
            settings['site']['wordpress_title']
        ]
    end

    # Allows access to port 80 on the guest using port 8080 on 
    # the host.
    config.vm.network :forwarded_port, guest: 80, host: 8080

    # Allows access to the guest from the host via static IP. The
    # IP chosen should be in the reserved private address space, 
    # which is 192.168.0.0 – 192.168.255.255.
    config.vm.network "private_network", ip: settings['site']['ip']

    # Link the /var/www/html folder on the guest to the ./www/
    # folder on the host.
    config.vm.synced_folder "./www/", "/var/www/html/"
end