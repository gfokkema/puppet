class site::pacaurtimer {
  site::timer { 'pacaur':
    description => 'PacAur Autoupdater',
    oncalendar  => 'daily',
    execstart   => '/usr/bin/bash -lc "pacaur -Syu --color never \
                    --noconfirm --noedit --noprogressbar \
                    | mail -s \'PacAur Autoupdater\' -v gerlof.fokkema@gmail.com"'
  }
}
