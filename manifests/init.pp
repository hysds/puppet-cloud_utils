#####################################################
# cloud_utils class
#####################################################

class cloud_utils inherits scientific_python {

  #####################################################
  # install packages
  #####################################################

  package { "awscli":
    provider => rpm,
    ensure   => present,
    source   => "/etc/puppet/modules/cloud_utils/files/awscli-1.8.8-1.x86_64.rpm",
    require => Package["python-virtualenv"],
  }


  #####################################################
  # install gof3r
  #####################################################

  file { '/usr/local/bin/gof3r':
    ensure  => file,
    mode    => 0755,
    source  => 'puppet:///modules/cloud_utils/gof3r',
  }


}
