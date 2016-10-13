define site::timer(
  String $description  = undef,
  String $oncalendar   = undef,
  Boolean $persistent  = true,

  String $requires     = '',
  String $after        = 'network.target',
  String $type         = 'oneshot',
  String $user         = 'gerlof',
  String $execstart    = undef,

  String $service      = "${name}.service",
  String $timer        = "${name}.timer",

  String $service_tmpl = 'systemd.service.erb',
  String $timer_tmpl   = 'systemd.timer.erb',

  String $systemd      = '/etc/systemd/system',
) {
  [ { file => $service,
      tmpl => $service_tmpl, },
    { file => $timer,
      tmpl => $timer_tmpl, },
  ].each | $index, $timer | {
    file { $timer['file']:
      ensure  => 'file',
      path    => "${systemd}/${timer['file']}",
      content => template("site/${timer['tmpl']}"),
    }
  }

  service { "${name}.timer":
    ensure => 'running',
    enable => true,
  }
}
