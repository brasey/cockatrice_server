class cockatrice_server::service {

  require cockatrice_server

  service { 'cockatrice':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
  }

}
