class cockatrice_server::users {

  group { 'cockatrice':
    ensure  => present,
  }

  user { 'cockatrice':
    ensure    => present,
    comment   => 'Cockatrice service account',
    password  => '!',
    shell     => '/sbin/nologin',
  }

  users { 'cockatrice': }

}
