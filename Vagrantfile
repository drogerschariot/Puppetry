# Puppetry 
#
# If you want to remove a client, simply comment out the define block.

Vagrant.configure("2") do |config|

   config.vm.define :puppetmaster do |puppetmaster|
        puppetmaster.vm.box          = "ubuntu-server-12.04.2"
        puppetmaster.vm.box_url      = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
        puppetmaster.vm.hostname     = "puppetmaster"
        puppetmaster.vm.network :private_network, ip: "192.168.100.100"
	puppetmaster.vm.network :forwarded_port, id: 'ssh', guest: 22, host: 2222
   end

   config.vm.define :puppetclient1 do |puppetclient1|
        puppetclient1.vm.box         = "debian-7"
        puppetclient1.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/debian-70rc1-x64-vbox4210.box"
        puppetclient1.vm.hostname    = "puppetclient1"
        puppetclient1.vm.network :private_network, ip: "192.168.100.101"
   end

   config.vm.define :puppetclient2 do |puppetclient2|
        puppetclient2.vm.box         = "centos-6.4"
        puppetclient2.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
				       "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
        puppetclient2.vm.hostname    = "puppetclient2"
        puppetclient2.vm.network :private_network, ip: "192.168.100.102"
   end

   config.vm.define :puppetclient3 do |puppetclient3|
        puppetclient3.vm.box         = "ubuntu-server-12.04.2"
        puppetclient3.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
        puppetclient3.vm.hostname    = "puppetclient3"
        puppetclient3.vm.network :private_network, ip: "192.168.100.103"
   end

   # Note that vagrant has a bug with the Fedora Template that will be fixed soon.
   config.vm.define :puppetclient4 do |ppuppetclient4|
       ppuppetclient4.vm.box         = "fedora-18"
       ppuppetclient4.vm.box_url     = "http://puppet-vagrant-boxes.puppetlabs.com/fedora-18-x64-vbox4210.box"
       ppuppetclient4.vm.hostname    = "puppetclient4"
       ppuppetclient4.vm.network :private_network, ip: "192.168.100.104"
   end

   config.vm.provision :puppet

end

