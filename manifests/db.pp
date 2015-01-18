class cockatrice_server::db {

  require cockatrice_server::build

  $override_options = {
    'server' => {
      root_password => 'new-password',
    }
  }

  class { '::mysql::server':
    override_options  => $override_options,
    service_enabled   => true,
    service_managed   => true,
  }

  concat { '/root/db_setup.sql':
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment { 'cockatrice db setup script':
    target  => '/root/db_setup.sql',
    source  => '/usr/local/src/cockatrice/servatrice/servatrice.sql',
    order   => '01',
  }

  concat::fragment { 'add admin wui user':
    target  => '/root/db_setup.sql',
    source  => 'puppet:///modules/cockatrice_server/add_admin.sql',
    order   => '02',
  }

  mysql::db { 'cockatrice':
    user      => 'cockatrice',
    password  => 'cockatrice',
    host      => 'localhost',
    grant     => 'ALL',
    sql       => '/root/db_setup.sql',
  }

}
