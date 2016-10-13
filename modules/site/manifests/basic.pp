class site::basic (
  Array[String] $install =
  [ 'abs',
    'base-devel',
    'bash-completion',
    'git',
    'lsof',
    'mlocate',
    'openssh',
    'pkgfile',
    'tmux',
    'tree',
    'vim', ],
  Array[String] $remove =
  [ 'vi', ],

  Array[String] $running =
  [ 'puppet',
    'sshd',
    'vmtoolsd', ],
  Array[String] $stopped =
  [],
) {
  $::os[family] ? {
    'Archlinux' =>
    { 'present' => $install,
      'absent'  => $remove, },
  }.each | $state, $packages | {
    package { $packages:
      ensure => $state,
    }
  }

  $::os[family] ? {
    'Archlinux' =>
    { { 'ensure' => 'running',
        'enable' => true, } => $running,
      { 'ensure' => 'stopped',
        'enable' => false, } => $stopped, },
  }.each | $state, $service | {
    service { $service:
      ensure => $state['ensure'],
      enable => $state['enable'],
    }
  }
}
