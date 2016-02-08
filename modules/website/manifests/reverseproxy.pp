class website::reverseproxy {
  class { 'apache':
    default_vhost => false,
  }

  apache::vhost { 'fokkema-ict.nl':
    port       => '8080',
    docroot    => '/srv/http',
    proxy_pass =>
    [ { path         => '/',
        url          => 'http://172.16.0.2:8080/',
        reverse_urls => [ 'http://172.16.0.2:8080/', ], },
    ],
  }
}
