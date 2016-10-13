node default {
  class { 'site::basic': }
  class { 'site::config': }
  class { 'site::pacaurtimer': }
  class { 'site::puppetagent': }

  case $::networking[hostname] {
    'arch':    { class { 'site::smarttimer': }
                 class { 'site::iperftimer': } }
    'puppet':  { class { 'site::puppetdb': } }
    'pptp':    { class { 'role::pptp': } }
    'samba':   { }
    'torrent': { }
  }
}
