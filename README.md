Puppetry
=================

Create a diverse puppet test environment in minutes using Vagrant. Puppetry will create 1 puppetmaster and 3 
clients.


###Install
- git clone git://github.com/drogerschariot/Puppetry.git
- cd Puppetry
- vagrant up

All clients will already be signed by the puppetmaster out of the box, so you can start testing manifests straight away.


###Usage
If you wish to exclude any puppet clients, edit the manifests/default.pp file and comment out the guest's define block.

To connect to a guest, run: <i>vagrant ssh \<hostname\></i>

Hostnames:<br />
<b>puppetmaster</b>:   Ubuntu Server 12.04 <br />
<b>puppetclient1</b>:  Debain 6            <br />
<b>puppetclient2</b>:	CentOS 6.4          <br />
<b>puppetclient3</b>:	Ubuntu Server 12.04 <br />


###Contrib
Fork and request.
