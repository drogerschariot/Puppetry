#
# Puppetry
#
# Installs puppetmaster and puppet dependencies on vagrant instances. 



$hosts = "192.168.100.100 puppetmaster
192.168.100.101 puppetclient1
192.168.100.102 puppetclient2
192.168.100.103 puppetclient3
192.168.100.104 puppetclient4
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

file { "/root/.ssh":
	ensure		=> directory,
	mode		=> 700,
}

# A helpful tip would be to add your own ssh public key :)
file { "/root/.ssh/authorized_keys":
	ensure 		=> present,
	mode 		=> 600,
	content		=> "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC90YHXnRFtTTLkdqdpnD1CxxrOSC/2V+iU9RuUtcPjHZESzSv8EFLgEft08BRfwKuKju69FvVt2H3VRdJqxRh5KGyV2JYpwp77wUNvFrX3hOjiRWqclfTNgdRxq4CUaoKZF3eDoPSeOmRdco0xrJDY4653961EzyKbP/l9NnoSK3E+2J1Zwe66ccgprCerAnDpRd594RPfc0yFqMX/1tyBv7010vy68PYS9xKwybZdyQoXdKSNDL5U4Nqfy9k/pws7yJ/MfTBts5+HIL1Ee4QNwrUgzPdjLX9Hooh6U7GsxWbWndWxiB3EATeCRNUvrzejwDYRdfGAHCKrwLHWbMLv drogers@sysadmin",
	require		=> File[ "/root/.ssh" ],
}


# If the VM is the puppetmaster, install puppetmaster packages and files.
if $hostname == "puppetmaster" {
	package { "puppetmaster":
		ensure 	=> present,
		require	=> File[ '/etc/hosts' ]
	}
	# Define auto signing to all client machines.
	file { "/etc/puppet/autosign.conf":
		ensure	=> file,
		mode	=> '755',
		owner	=> 'root',
		group	=> 'root',
		require	=> Package[ 'puppetmaster' ],
		content	=> "*",
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
 #If puppet client, connect to puppetmaster once to create key pair.
else {
	exec { 'puppetclient':
		command		=> "puppet agent --server puppetmaster --test",
		path		=> '/usr/bin:/usr/sbin:/bin:/sbin:/user/local/bin',
		require		=> [ Package [ 'puppet' ], File[ '/etc/hosts' ], ],
	}
}
