class site::config(
  Array[String] $rc_map         =
  [ '/etc/bash.bashrc',
    '/etc/tmux.conf',
    '/etc/vimrc', ],
  Array[String] $rc_tmpl_map    =
  [ '/etc/mail.rc', ],
  Array[String] $completion_map =
  [ '/usr/share/git/completion/git-prompt.sh',
    '/usr/share/git/completion/git-completion.bash', ],

  String $completion            = '/etc/bash_completion.d',
) {
  file { '/usr/bin/vi':
    ensure => 'link',
    target => 'vim',
  }

  #
  # Install dotfiles to the location specified in $rc_map.
  # Puppet will look for the source in {module_path}/files/basename($rc_file)
  #
  $rc_map.map | $rc | {
    { basename => basename($rc),
      target   => $rc, }
  }.each | $index, $rc | {
    file { $rc['target']:
      ensure => 'file',
      source => "puppet://puppet/modules/site/${rc['basename']}",
    }
  }

  #
  # Install templated dotfiles to the location specified in $rc_tmpl_map.
  # Puppet will look for the source in {module_path}/templates/basename($rc_tmpl_file)
  #
  $rc_tmpl_map.map | $rc_tmpl | {
    { basename => basename($rc_tmpl),
      target   => $rc_tmpl, }
  }.each | $index, $rc | {
    file { $rc['target']:
      ensure  => 'file',
      content => template("site/${rc['basename']}.erb"),
    }
  }

  #
  # Install BASH completion symlinks from source files specified in $completion_map.
  # Puppet will name these links as basename($completion_file)
  #
  file { $completion:
    ensure => 'directory',
  }
  $completion_map.map | $script | {
    { basename => basename($script),
      target   => $script, }
  }.each | $index, $script | {
    file { "${completion}/${script['basename']}":
      ensure => 'link',
      target => $script['target'],
    }
  }
}
