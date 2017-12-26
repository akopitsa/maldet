# Class: postinstall
#
#
class maldet::postinstall (
  String $version = $maldet::version,
) inherits maldet {
  file {'/tmp/maldetect-current.tar.gz':
    alias   => 'remove',
    ensure  => absent,
    source  => '/tmp/maldetect-current.tar.gz',
  }
  file {"/tmp/maldet-$version":
    ensure  => absent,
    path    => "/tmp/maldet-$version",
    recurse => true,
    purge   => true,
    force   => true,
  }
}
