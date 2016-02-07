class site::config(
  String $bashrc               = '/etc/bash.bashrc',
  String $completion           = '/etc/bash_completion.d',
  Array[String] $completion_map =
  [ '/usr/share/git/completion/git-prompt.sh',
    '/usr/share/git/completion/git-completion.bash' ],
  String $tmuxrc               = '/etc/tmux.conf',
  String $vimrc                = '/etc/vimrc',
) {
  File {
    ensure => file,
  }

  file { $bashrc:
    content => template('site/bash.bashrc.erb'),
  }

  file { $tmuxrc:
    content => template('site/tmux.conf.erb'),
  }

  file { $vimrc:
    content => template('site/vimrc.erb'),
  }

  file { $completion:
    ensure => 'directory',
  }

  file { '/usr/bin/vi':
    ensure => link,
    target => 'vim',
  }

  $base_map = $completion_map.map | $script | {
    { basename => basename($script),
      target   => $script }
  }

  $base_map.each | $index, $script | {
    file { "${completion}/${script[basename]}":
      ensure => link,
      target => $script[target],
    }
  }
}
