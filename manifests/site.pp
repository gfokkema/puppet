node default {
  class { 'site::basic': }
  class { 'site::config': }
  site::timer { 'pacaur': }

  case $::networking[hostname] {
    'puppet': { class { 'site::puppetdb': } }
    'arch':   { site::timer { 'smart': } }
  }
}
