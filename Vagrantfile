# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
    
    # Ubuntu 18.04 LTS
    config.vm.box = "ubuntu/bionic64"

    config.vm.provision :shell, path: "bootstrap.sh"

    # Allows access to port 80 on the guest using port 8080 on 
    # the host.
    config.vm.network :forwarded_port, guest: 80, host: 8080

    # Allows access to the guest from the host via static IP. The
    # IP chosen should be in the reserved private address space, 
    # which is 192.168.0.0 – 192.168.255.255.
    config.vm.network "private_network", ip: "192.168.50.4"

    # Link the /var/www/html folder on the guest to the ./www/
    # folder on the host.
    config.vm.synced_folder "./www/", "/var/www/html/"
end