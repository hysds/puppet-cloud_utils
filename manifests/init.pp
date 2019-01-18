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

  package { "azure-cli":
    provider => rpm,
    ensure   => present,
    source   => "/etc/puppet/modules/cloud_utils/files/azure-cli-2.0.31-1.el7.x86_64.rpm",
    require => Package["python-virtualenv"],
  }

  file_line { "AzureAuthLocation":
    ensure => present,
    path   => "/home/ops/.bashrc",
    line   => "export AZURE_AUTH_LOCATION=~/.azure/azure_credentials.json",
    match  => "^export AZURE_AUTH_LOCATION=",
  }


  #####################################################
  # install gof3r
  #####################################################

  file { '/usr/local/bin/gof3r':
    ensure  => file,
    mode    => 0755,
    source  => 'puppet:///modules/cloud_utils/gof3r',
  }


  #####################################################
  # configure sshd to not drop idle connections
  #####################################################

  service { 'sshd':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }


  file_line { "ClientAliveInterval":
    ensure => present,
    line   => "ClientAliveInterval 30",
    path   => "/etc/ssh/sshd_config",
    match  => "^ClientAliveInterval",
    notify => Service['sshd'],
  }


  file_line { "ClientAliveCountMax":
    ensure => present,
    line   => "ClientAliveCountMax 99999",
    path   => "/etc/ssh/sshd_config",
    match  => "^ClientAliveCountMax",
    notify => Service['sshd'],
  }


}
