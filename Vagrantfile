# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

   config.vm.define :puppet-master do |puppet-master|
        puppet-master.vm.box          = "ubuntu-server-12.04.2"
        puppet-master.vm.box_url      = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
        puppet-master.vm.hostname     = "puppet-master"
        puppet-master.vm.network :private_network, ip: "192.168.100.100"
   end

   config.vm.define :puppet-client1 do |puppet-client1|
        puppet-client1.vm.box         = "debian-7"
        puppet-client1.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"
        puppet-client1.vm.hostname    = "puppet-client1"
        puppet-client1.vm.network :private_network, ip: "192.168.100.101"
   end

   config.vm.define :puppet-client2 do |puppet-client2|
        puppet-client2.vm.box         = "centos-6.4"
        puppet-client2.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
        puppet-client2.vm.hostname    = "puppet-client2"
        puppet-client2.vm.network :private_network, ip: "192.168.100.102"
   end

   config.vm.define :puppet-client3 do |puppet-client3|
        puppet-client3.vm.box         = "ubuntu-server-12.04.2"
        puppet-client3.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
        puppet-client3.vm.hostname    = "puppet-client3"
        puppet-client3.vm.network :private_network, ip: "192.168.100.103"
   end

   #config.vm.define :puppet-client4 do |ppuppet-client4|
   #    ppuppet-client4.vm.box         = "fedora-18-x64"
   #    ppuppet-client4.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210.box"
   #    ppuppet-client4.vm.hostname    = "puppet-client3"
   #    ppuppet-client4.vm.network :private_network, ip: "192.168.100.104"
   #end


   config.vm.provision :puppet

end

