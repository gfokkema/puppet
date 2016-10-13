class site::iperftimer {
  site::timer { 'iperf':
    description => 'Iperf autorunner',
    oncalendar  => 'hourly',
    type        => 'simple',
    execstart   => '/usr/bin/iperf3 -u -p 5201 -c smokeping.gntel.nl -i 10 -t 3570 -l 214 -b 85600 --logfile /var/log/iperf.log'
  }
}
