class cockatrice_server::service {

  require cockatrice_server

# Place server config file

  file { '/etc/servatrice/servatrice.ini':
    ensure      => file,
    owner       => $cockatrice_server::params::service_user,
    group       => $cockatrice_server::params::service_user,
    mode        => '0600',
    content     => template('cockatrice_server/servatrice.ini.erb'),
    notify      => Service[ 'cockatrice' ],
  }

# And a systemd service file to make it go and stop

  file { '/usr/lib/systemd/system/cockatrice.service':
    ensure      => file,
    owner       => 'root',
    group       => 'root',
    mode        => '0644',
    source      => 'puppet:///modules/cockatrice_server/cockatrice.service',
  }

  service { 'cockatrice':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require     => File[ '/etc/servatrice/servatrice.ini',
                          '/usr/lib/systemd/system/cockatrice.service' ],
  }

}
