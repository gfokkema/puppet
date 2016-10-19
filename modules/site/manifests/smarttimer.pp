class site::smarttimer {
  site::timer {
    'smart':
      description => 'SMART status mailer',
      oncalendar  => 'weekly',
      execstart   => '/usr/bin/bash -c "ssh root@192.168.0.254 \' \
                      for i in $(esxcli storage core device list | grep -E \'^t10\'); \
                      do echo \'------------------------------------------------------\'; \
                         echo $i; \
                         echo \'------------------------------------------------------\'; \
                         esxcli storage core device smart get -d $i; \
                      done\' | mail -s \'SMART status\' -v gerlof.fokkema@gmail.com"'
  }
}
