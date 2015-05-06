class timeservice::install {
  file { '/opt/ts':
    ensure => directory,

  } ->

  exec { 'Installation of TimeService':
    command => '/bin/cp -n /exchange/timeservice.jar /opt/ts',
  } ->


  # We need a user account for the service

  user { 'timeservice': # creates also a group
    ensure  => present,
  } ->

  file { '/etc/init/timeservice.conf':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('timeservice/etc/init/timeservice.conf'),
    notify  => Service["timeservice"],
  }

}