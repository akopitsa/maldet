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
  file {"remove":
    ensure  => absent,
    path    => "/tmp/maldetect-$version",
    recurse => true,
    purge   => true,
    force   => true,
  }
  notify { '/tmp/maldetect-$version':
  message => "/tmp/maldetect-$version"
  }
}
