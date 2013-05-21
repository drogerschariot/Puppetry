#
# Puppetry
#
# Installs puppetmaster and puppet dependencies on vagrant instances. 

# Change to your domain
$DOMAIN = "chariotsolutions.com"

$hosts = "192.168.100.100 puppetmaster puppetmaster.${DOMAIN}
192.168.100.101 puppetclient1 puppetclient1.${DOMAIN}
192.168.100.102 puppetclient2 puppetclient2.${DOMAIN}
192.168.100.103 puppetclient3 puppetclient3.${DOMAIN}
192.168.100.104 puppetclient4 puppetclient4.${DOMAIN}
"

# Get some distro specific names and packages. 
case $operatingsystem {
		Ubuntu, debian: {
			$vim = "vim"
			package { "build-essential":
				ensure 	=> present,
				require	=> Exec [ "apt_update" ],
			}
			exec { "apt_update":
			        command         => "apt-get update",
			        path            => "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
				before		=> Package[ 'vim', 'git', 'puppet' ],
			}
		}
		CentOS, Fedora, RedHat: {
			$vim = "vim-common"
			exec { "build-essential":
				command => "yum -y groupinstall \"Development Tools\"",
				path 	=> "/usr/bin:/usr/sbin:/bin:/usr/local/bin",
			}
		}
}

# Sorry I like vim :)
package { "vim":
	name 		=> $vim,
	ensure 		=> present,
}
package { 'git':
	ensure		=> present,
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
		require	=> $osfamily ? { # If debain family, make sure apt-update runs
			'Debain' => "Exec[ 'apt_update' ]",
			default	 => undef,
		},
	}
	# Define auto signing to all client machines.
	file { "/etc/puppet/autosign.conf":
		ensure	=> file,
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
