# Class: wordpress
# ===========================
#
# Full description of class wordpress here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'wordpress':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class wordpress {
    # Load all variables
    class { 'wordpress::conf': }

    # Install Apache and PHP
    class { 'wordpress::web': }

    # Install MySQL
    class { 'wordpress::db': }

    # Run Wordpress installation only after Apache is installed
    class { 'wordpress::wp': 
        require => Notify['Apache Installation Complete']
    }

    # Display this message after MySQL installation is complete
    notify { 'MySQL Installation Complete':
        require => Class['wordpress::db']
    }

    # Display this message after Apache installation is complete
    notify { 'Apache Installation Complete':
        require => Class['wordpress::web']
    }

    # Display this message after Wordpress installation is complete
    notify { 'Wordpress Installation Complete':
        require => Class['wordpress::wp']
    }

}
