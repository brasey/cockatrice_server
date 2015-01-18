class cockatrice_server::prereqs {

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

}
