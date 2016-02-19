define site::timer(
  String $service = "${name}.service",
  String $timer   = "${name}.timer",
) {
  [ $service, $timer, ].each | $index, $file | {
    file { "${file}":
      ensure => 'file',
      path   => "/etc/systemd/system/${file}",
      source => "puppet://puppet/modules/site/${file}",
    }
  }

  service { "${name}.timer":
    enable => true,
  }
}
