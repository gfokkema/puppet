class site::basic (
  Array[String] $install =
  [ 'abs',
    'base-devel',
    'bash-completion',
    'git',
    'lsof',
    'mlocate',
    'openssh',
    'tmux',
    'vim', ],
  Array[String] $remove =
  [ 'vi', ],

  Array[String] $running =
  [ 'puppet',
    'sshd',
    'vmtoolsd', ],
  Array[String] $stopped =
  [],

  Array[String] $modules =
  [ 'site::pacaurtimer', ],
) {
  $::os[family] ? {
    'Archlinux' => { 'present' => $install,
                     'absent'  => $remove, },
  }.each | $state, $packages | {
    package { $packages:
      ensure => $state,
    }
  }

  $::os[family] ? {
    'Archlinux' =>
    { { 'enable' => true,
        'ensure' => 'running', } => $running,
      { 'enable' => false,
        'ensure' => 'stopped', } => $stopped, },
  }.each | $state, $service | {
    service { $service:
      enable => $state['enable'],
      ensure => $state['ensure'],
    }
  }

  $::os[family] ? {
    'Archlinux' => $modules,
  }.each | $module | {
    class { $module: }
  }
}
