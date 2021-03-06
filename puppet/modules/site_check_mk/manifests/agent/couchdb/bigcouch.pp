# configure logwatch and nagios checks for bigcouch
class site_check_mk::agent::couchdb::bigcouch {

  # watch bigcouch logs
  # currently disabled because bigcouch is too noisy
  # see https://leap.se/code/issues/7375 for more details
  # and site_config::remove_files for removing leftovers
  #file { '/etc/check_mk/logwatch.d/bigcouch.cfg':
  #  source => 'puppet:///modules/site_check_mk/agent/logwatch/bigcouch.cfg',
  #}

  # check syslog msg from:
  # - empd
  # - /usr/local/bin/couch-doc-update
  concat::fragment { 'syslog_bigcouch':
    source  => 'puppet:///modules/site_check_mk/agent/logwatch/syslog/bigcouch.cfg',
    target  => '/etc/check_mk/logwatch.d/syslog.cfg',
    order   => '02';
  }

  # check bigcouch processes
  augeas {
    'Bigcouch_epmd_procs':
      incl    => '/etc/check_mk/mrpe.cfg',
      lens    => 'Spacevars.lns',
      changes => [
        'rm /files/etc/check_mk/mrpe.cfg/Bigcouch_epmd_procs',
        'set Bigcouch_epmd_procs \'/usr/lib/nagios/plugins/check_procs -w 1:1 -c 1:1 -a /opt/bigcouch/erts-5.9.1/bin/epmd\'' ],
      require => File['/etc/check_mk/mrpe.cfg'];
    'Bigcouch_beam_procs':
      incl    => '/etc/check_mk/mrpe.cfg',
      lens    => 'Spacevars.lns',
      changes => [
        'rm /files/etc/check_mk/mrpe.cfg/Bigcouch_beam_procs',
        'set Bigcouch_beam_procs \'/usr/lib/nagios/plugins/check_procs -w 1:1 -c 1:1 -a /opt/bigcouch/erts-5.9.1/bin/beam\'' ],
      require => File['/etc/check_mk/mrpe.cfg'];
  }

  augeas {
    'Bigcouch_open_files':
      incl    => '/etc/check_mk/mrpe.cfg',
      lens    => 'Spacevars.lns',
      changes => [
        'rm /files/etc/check_mk/mrpe.cfg/Bigcouch_open_files',
        'set Bigcouch_open_files \'/srv/leap/nagios/plugins/check_unix_open_fds.pl -a beam -w 28672,28672 -c 30720,30720\'' ],
      require => File['/etc/check_mk/mrpe.cfg'];
  }

}
