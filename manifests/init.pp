class cockatrice_server {

  include epel
  requires cockatrice_server::users

  package { [
              'gcc',
              'gcc-c++',
              'qt-devel',
              'git',
              'protobuf-devel',
              'protobuf-compiler',
              'cmake',
              'libgcrypt-devel',
            ]:
    ensure  => installed,
  }

  file { '/usr/local/src/cockatrice':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0775',
  }

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
    command => '/usr/bin/cmake -DWITH_SERVER=1 -DWITH_CLIENT=0 -DWITH_ORACLE=1 -DWITH_QT4=1 ..',
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/src/cockatrice/build/Makefile',
    require => File[ '/usr/local/src/cockatrice/build' ],
  }

  exec { 'run make':
    command => '/usr/bin/make',
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/src/cockatrice/build/servatrice/servatrice',
    require => Exec[ 'run cmake' ],
  }

  exec { 'run make install':
    command => '/usr/bin/make install',
    cwd     => '/usr/local/src/cockatrice/build',
    user    => 'root',
    creates => '/usr/local/bin/servatrice',
    require => Exec[ 'run make' ],
  }

# Open a port in the firewall

  class { 'firewalld::configuration':
    default_zone  => 'public',
  }

  firewalld::zone { 'public':
    description => 'For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.',
    services    => ['ssh', 'dhcpv6-client'],
    ports       => [{
                port      => '4747',
                protocol  => 'tcp',
    },]
  }

# And a systemd service file to make it go and stop

  file { '/usr/lib/systemd/system/cockatrice.service':
    ensure      => file,
    owner       => 'root',
    group       => 'root',
    mode        => '0644',
    source      => 'puppet:///modules/cockatrice_server/cockatrice.service',
  }

}
