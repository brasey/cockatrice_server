class cockatrice_server::directories {

  require cockatrice_server::users
  require cockatrice_server::params

  file { '/usr/local/src/cockatrice':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
  }

  file { '/srv/cockatrice':
    ensure  => directory,
    owner   => $cockatrice_server::params::service_user,
    group   => $cockatrice_server::params::service_user,
    mode    => '0775',
  }

  file { '/etc/servatrice':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
  }

}
