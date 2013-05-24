Puppetry
=================

Create a diverse puppet test environment in minutes using Vagrant.


###Install
- git clone https://github.com/drogerschariot/Puppetry.git
- cd Puppetry
- In manifests/default.pp, change the $DOMAIN variable to your domain
- vagrant up

All clients will already be signed by the master out of the box so you can start testing manifests straight away.


###Usage
If you wish to exclude any puppet clients, edit the manifests/default.pp file and comment out the guest's define block.

To connect run: <i>vagrant ssh \<hostname\></i>

Hostnames:<br />
<b>puppetmaster</b>:   Ubuntu Server 12.04 <br />
<b>puppetclient1</b>:  Debain 6            <br />
<b>puppetclient2</b>:	CentOS 6.4          <br />
<b>puppetclient3</b>:	Ubuntu Server 12.04 <br />

You can also ssh to the puppetmaster guest from a remote computer via port 2222 on the host.

###Contrib
Fork and request.
