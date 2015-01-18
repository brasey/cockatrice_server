class cockatrice_server {

  include cockatrice_server::users
  require cockatrice_server::directories
  require cockatrice_server::prereqs
  include cockatrice_server::db

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
