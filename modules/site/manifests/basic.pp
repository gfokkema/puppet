class site::basic {
  $install =
  [ 'abs',
    'base-devel',
    'bash-completion',
    'lsof',
    'mlocate',
    'openssh',
    'tmux',
    'vim', ]
  $remove =
  [ 'vi', ]

  $basic = { 'present' => $install,
             'absent'  => $remove, }
  $service = { 'running' => [ 'sshd', ] }

  $packagehash = $::os[family] ? {
    'Archlinux' => $basic,
  }

  $packagehash.each | $state, $packages | {
    package { $packages:
      ensure => $state,
    }
  }
}
