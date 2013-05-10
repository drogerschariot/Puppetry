# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

   config.vm.define :puppetm do |puppetm|
	puppetm.vm.box 		= "ubuntu-server-x64"
	puppetm.vm.box_url	= "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-10044-x64-vbox4210.box"
	puppetm.vm.hostname 	= "puppet-master"
	puppetm.vm.network :private_network, ip: "192.168.100.100"
   end

   config.vm.define :puppetc1 do |puppetc1|
	puppetc1.vm.box 	= "debian-7-x64"
	puppetc1.vm.box_url	= "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"
	puppetc1.vm.hostname	= "puppet-client1"
	puppetc1.vm.network :private_network, ip: "192.168.100.101"
   end

   config.vm.define :puppetc2 do |puppetc2|
	puppetc2.vm.box		= "centos-puppet"
	puppetc2.vm.box_url	= "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
	puppetc2.vm.hostname	= "puppet-client2"
	puppetc2.vm.network :private_network, ip: "192.168.100.102"
   end

   #config.vm.define :puppetc3 do |puppetc3|
   #	puppetc3.vm.box		= "fedora-18-x64"
   #	puppetc3.vm.box_url	= "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210.box"
   #	puppetc3.vm.hostname	= "puppet-client3"
   #	puppetc3.vm.network :private_network, ip: "192.168.100.103"
   #end

   config.vm.define :puppetc4 do |puppetc4|
        puppetc4.vm.box         = "ubuntu-server-x64"
        puppetc4.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-10044-x64-vbox4210.box"
        puppetc4.vm.hostname    = "puppet-client4"
        puppetc4.vm.network :private_network, ip: "192.168.100.104"
   end

   config.vm.provision :puppet

end
