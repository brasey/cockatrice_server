class cockatrice_server::params {

# Some file paths that you may have to set for your OS

  case $::operatingsystem {
    default:  {
      $cmake  = '/usr/bin/cmake'
      $make   = '/usr/bin/make'
    }
  }

  $server_name      = hiera('server_name', 'Cockatrice server')
  $port             = hiera('port', '4747')
  $service_user     = hiera('service_user', 'cockatrice')
  $db_name          = hiera('db_name', 'cockatrice')
  $db_root_password = hiera('db_root_password', 'password')
  $db_user          = hiera('db_user', 'cockatrice')
  $db_password      = hiera('db_password', 'cockatrice')

}
