class site::puppetdb {
  class { 'puppetdb':
    listen_address      => '0.0.0.0',
    manage_package_repo => false,
    store_usage         => 2000,
    temp_usage          => 2000,
  }
  class { 'puppetdb::master::config': }

  package { 'puppet-lint':
    ensure => 'present',
  }
}
