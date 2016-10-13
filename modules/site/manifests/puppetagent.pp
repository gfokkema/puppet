class site::puppetagent (
  $puppet_conf         = $puppetdb::params::puppet_conf,
  $puppet_conf_section = 'main',
) inherits puppetdb::params {
  Ini_setting {
    section => $puppet_conf_section,
    path    => $puppet_conf,
    ensure  => present,
  }

  ini_setting { "puppet.conf/${puppet_conf_section}/server":
    setting => 'server',
    value   => 'puppet.fokkema.local',
  }
}
