class cockatrice_server::users {

  group { 'cockatrice':
    ensure  => present,
  }

  user { 'cockatrice':
    ensure    => present,
    groups    => [ 'cockatrice' ],
    comment   => 'Cockatrice service account',
    password  => '!',
    shell     => '/sbin/nologin',
    require   => Group[ 'cockatrice' ],
  }

}
