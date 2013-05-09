#
# Default base config and packages for Vagrant
#
# Base Packages:
#	-- vim
#	-- puppet
#	-- build-essensials
#
#

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
			        before          => Package[ "vim", "puppet" ],
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
