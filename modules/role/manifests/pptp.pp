class role::pptp {
  package { [ 'pam-krb5', 'pptpd', 'samba', ]:
    ensure => 'present',
  }
  ->
  file { '/etc/samba/smb.conf':
  }
  -> # Join domain somehow here.
  file { '/etc/pptpd.conf':
  }
  ->
  file { '/etc/ppp/options':
  }
  ->
  service { [ 'pptpd', 'winbindd', ]:
    ensure => 'running',
    enable => true,
  }
}
