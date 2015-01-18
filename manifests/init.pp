class cockatrice_server {

  include cockatrice_server::users
  require cockatrice_server::params
  require cockatrice_server::directories
  require cockatrice_server::prereqs
  include cockatrice_server::db
  include cockatrice_server::service

# Open a port in the firewall

  class { 'firewalld::configuration':
    default_zone  => 'public',
  }

  firewalld::zone { 'public':
    description => 'For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted.',
    services    => ['ssh', 'dhcpv6-client'],
    ports       => [{
                port      => $cockatrice_server::params::port,
                protocol  => 'tcp',
    },]
  }

}
