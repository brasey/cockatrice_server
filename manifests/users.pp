class cockatrice_server::users {

  require cockatrice_server::params

  group { $cockatrice_server::params::service_user:
    ensure  => present,
  }

  user { $cockatrice_server::params::service_user:
    ensure    => present,
    groups    => [ $cockatrice_server::params::service_user ],
    comment   => 'Cockatrice service account',
    password  => '!',
    shell     => '/sbin/nologin',
    require   => Group[ $cockatrice_server::params::service_user ],
  }

}
