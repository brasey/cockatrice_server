class cockatrice_server::directories {

  require cockatrice_server::users

  file { '/usr/local/src/cockatrice':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
  }

  file { '/srv/cockatrice':
    ensure  => directory,
    owner   => 'cockatrice',
    group   => 'cockatrice',
    mode    => '0775',
  }

}
