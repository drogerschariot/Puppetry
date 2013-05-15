#
# Default base config and packages for Vagrant
#
# Base Packages:
#	-- vim
#	-- puppet
#	-- build-essensials
#
#

$DOMAIN = "chariotsolutions.com"

$hosts = "192.168.100.100 puppetmaster puppetmaster.${DOMAIN}
192.168.100.101 puppetclient1 puppetclient1.${DOMAIN}
192.168.100.102 puppetclient2 puppetclient2.${DOMAIN}
192.168.100.103 puppetclient3 puppetclient3.${DOMAIN}
192.168.100.104 puppetclient4 puppetclient4.${DOMAIN}
"

case $operatingsystem {
		Ubuntu, debian: {
			
			# Distro specific variables 
			$vim = "vim"

			# Distro specific Types
			package { "build-essential":
				ensure 	=> present,
				require	=> Exec [ "apt_update" ],
			}
			exec { "apt_update":
			        command         => "apt-get update",
			        path            => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
			}
		}
		CentOS, Fedora, RedHat: {

			# Distro specific variables
			$vim = "vim-common"

			# Distro specific Types
			exec { "build-essential":
				command => "yum -y groupinstall \"Development Tools\"",
				path 	=> "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
			}
		}
}

package { "vim":
	name 		=> $vim,
	ensure 		=> present,
}

package { "puppet":
	ensure 		=> present,
}

file { "/etc/sudoers":
	ensure 		=> file,
	mode   		=> 0440,
	owner  		=> 'root',
	group  		=> 'root',
}

# Addes puppetmaster and all client FQDN to all hosts.
file { "/etc/hosts":
	ensure		=> file,
	content		=> "${hosts}",
}

# If the VM is the puppetmaster, install puppetmaster packages and files.
if $fqdn == "puppetmaster.${DOMAIN}" {
	package { "puppetmaster":
		ensure 	=> present,
		require	=> $osfamily ? {
			'Debain' => "Exec[ 'apt_update' ]",
			default	 => undef,
		},
	}
	file { "/etc/puppet/autosign.conf":
		ensure	=> present,
		mode	=> '755',
		owner	=> 'root',
		group	=> 'root',
		require	=> Package[ 'puppetmaster' ],
		content	=> "*.${DOMAIN}",
	}
	service { 'puppetmaster':
		enable 		=> true,
		ensure		=> running,
		require 	=> [ 
					Package[ 'puppetmaster' ], 
					File[ '/etc/hosts' ],
					File[ '/etc/puppet/autosign.conf' ],
				   ],
	}
}
# If puppet client, connect to puppetmaster once to create key pair.
else {
	exec { 'puppetclient':
		command		=> "puppet agent --server puppetmaster.${DOMAIN} --test",
		path		=> '/usr/bin:/usr/sbin:/bin:/sbin:/user/local/bin',
		require		=> Package [ 'puppet' ],
	}
}
