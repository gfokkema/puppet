class site::basic (
  $install =
  [ 'abs',
    'base-devel',
    'bash-completion',
    'git',
    'lsof',
    'mlocate',
    'openssh',
    'tmux',
    'vim', ],
  $remove =
  [ 'vi', ],

  $services = { 'running' => [ 'sshd', 'vmtoolsd', ] },
) {
  $::os[family] ? {
    'Archlinux' => { 'present' => $install,
                     'absent'  => $remove, },
  }.each | $state, $packages | {
    package { $packages:
      ensure => $state,
    }
  }

  $services.each | $state, $service | {
    service { $service:
      ensure => $state,
    }
  }
}
