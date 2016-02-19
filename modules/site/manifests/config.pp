class site::config(
  Array[String] $rc_map         =
  [ '/etc/bash.bashrc',
    '/etc/tmux.conf',
    '/etc/vimrc', ],
  String $completion            = '/etc/bash_completion.d',
  Array[String] $completion_map =
  [ '/usr/share/git/completion/git-prompt.sh',
    '/usr/share/git/completion/git-completion.bash', ],
) {
  service { 'puppet':
    ensure => 'running',
    enable => true,
  }

  file { '/usr/bin/vi':
    ensure => 'link',
    target => 'vim',
  }

  $rc_base_map = $rc_map.map | $rc | {
    { basename => basename($rc),
      target   => $rc, }
  }.each | $index, $rc | {
    file { $rc['target']:
      ensure => 'file',
      source => "puppet://puppet/modules/site/${rc['basename']}",
    }
  }

  file { $completion:
    ensure => 'directory',
  }

  $base_map = $completion_map.map | $script | {
    { basename => basename($script),
      target   => $script, }
  }.each | $index, $script | {
    file { "${completion}/${script['basename']}":
      ensure => 'link',
      target => $script['target'],
    }
  }
}
