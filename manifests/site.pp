node default {
  class { 'site::basic': }
  class { 'site::config': }

  case $::networking[hostname] {
    'arch':    { class { 'site::smarttimer': }
                 class { 'site::iperftimer': } }
    'puppet':  { class { 'site::puppetdb': } }
  }
}
