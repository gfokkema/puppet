node default {
  class { 'helloworld': }
  class { 'site::basic': }

  # case $::networking[hostname] {
  #   'puppet': { class { 'puppetdb':
  #                         manage_package_repo => false, }
  #               class { 'puppetdb::master::config': } }
  #   'puppet': { package { 'puppetdb-terminus':
  #                           ensure => present, } }
  # }
}
