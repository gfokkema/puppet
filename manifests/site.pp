node default {
  class { 'site::basic': }
  class { 'site::config': }

  case $::networking[hostname] {
    'puppet': { class { 'site::puppetdb': } }
    'arch':   { class { 'site::smarttimer': } }
  }
}
