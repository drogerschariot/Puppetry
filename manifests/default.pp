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

$hosts = "192.168.100.100 puppet-master puppet-master.${DOMAIN}
192.168.100.101 puppet-client1 puppet-client1.${DOMAIN}
192.168.100.102 puppet-client2 puppet-client2.${DOMAIN}
192.168.100.103 puppet-client3 puppet-client3.${DOMAIN}
192.168.100.104 puppet-client4 puppet-client4.${DOMAIN}
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
			        before          => Package[ "vim", "puppet", "puppetmaster" ],
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

file { "/etc/hosts":
	ensure		=> file,
	content		=> "${hosts}",
}

if $fqdn == "puppet-master.${DOMAIN}" {
	package { "puppetmaster":
		ensure => present,
	}
}
