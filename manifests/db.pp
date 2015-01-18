class cockatrice_server::db {

  require cockatrice_server::build
  require cockatrice_server::params

  class { '::mysql::server':
    root_password     => 'new-password',
    service_enabled   => true,
    service_manage    => true,
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

  file { '/root/add_admin.sql':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template('cockatrice_server/add_admin.sql.erb'),
  }

  concat::fragment { 'add admin wui user':
    target  => '/root/db_setup.sql',
    source  => '/root/add_admin.sql',
    order   => '02',
    require => File[ '/root/add_admin.sql' ],
  }

  mysql::db { $cockatrice_server::params::db_name:
    user      => $cockatrice_server::params::db_user,
    password  => $cockatrice_server::params::db_password,
    host      => 'localhost',
    grant     => 'ALL',
    sql       => '/root/db_setup.sql',
    require   => Concat::Fragment[ 'add admin wui user' ],
  }

}
