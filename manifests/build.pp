class cockatrice_server::build {

  require cockatrice_server

  vcsrepo { '/usr/local/src/cockatrice':
    ensure    => present,
    provider  => git,
    source    => 'https://github.com/Cockatrice/Cockatrice.git',
    require   => File[ '/usr/local/src/cockatrice' ],
  }

  file { '/usr/local/src/cockatrice/build':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
    require => Vcsrepo[ '/usr/local/src/cockatrice' ],
  }

  exec { 'run cmake':
    command => "${cockatrice_server::params::cmake} -DWITH_SERVER=1 -DWITH_CLIENT=0 -DWITH_ORACLE=1 -DWITH_QT4=1 ..",
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/src/cockatrice/build/Makefile',
    require => File[ '/usr/local/src/cockatrice/build' ],
  }

  exec { 'run make':
    command => $cockatrice_server::params::make,
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/src/cockatrice/build/servatrice/servatrice',
    require => Exec[ 'run cmake' ],
  }

  exec { 'run make install':
    command => "${cockatrice_server::params::make} install",
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/bin/servatrice',
    require => Exec[ 'run make' ],
  }

}
