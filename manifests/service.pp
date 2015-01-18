class cockatrice_server::service {

  require cockatrice_server

# Place server config file

  file { '/srv/cockatrice/servatrice.ini':
    ensure      => file,
    owner       => 'cockatrice',
    group       => 'cockatrice',
    mode        => '0644',
    source      => 'puppet:///modules/cockatrice_server/servatrice.ini',
    notify      => Cockatrice_server::Service[ 'cockatrice' ],
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
    require     => File[ '/srv/cockatrice/servatrice.ini',
                          '/usr/lib/systemd/system/cockatrice.service' ],
  }

}
