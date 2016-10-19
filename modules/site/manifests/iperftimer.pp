class site::iperftimer {
  site::timer { 'iperf':
    description => 'Iperf gnTel autorunner',
    oncalendar  => 'hourly',
    type        => 'simple',
    user        => 'root',
    execstart   => '/usr/bin/iperf3 -u -p 5201 -c smokeping.gntel.nl -i 10 -t 3570 -l 214 -b 85600 --logfile /var/log/iperf.log'
  }

  site::timer { 'iperf-amazon':
    description => 'Iperf Amazon autorunner',
    oncalendar  => 'hourly',
    type        => 'simple',
    user        => 'root',
    execstart   => '/usr/bin/iperf3 -u -p 5202 -c 52.57.119.247 -i 10 -t 3570 -l 214 -b 85600 --logfile /var/log/iperf-amazon.log'
  }

  site::timer { 'iperf-google':
    description => 'Iperf Google autorunner',
    oncalendar  => 'hourly',
    type        => 'simple',
    user        => 'root',
    execstart   => '/usr/bin/iperf3 -u -p 5203 -c 104.199.54.127 -i 10 -t 3570 -l 214 -b 85600 --logfile /var/log/iperf-google.log'
  }
}
