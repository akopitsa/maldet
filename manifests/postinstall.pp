# Class: postinstall
#
#
class maldet::postinstall (
  String $version = $maldet::version,
) inherits maldet {
  file {"/tmp/$version.tar.gz":
    alias   => 'removearchive',
    ensure  => absent,
    source  => "/tmp/$version.tar.gz",
  }
  # file {"linux-malware-detect-$version":
  #   ensure  => absent,
  #   path    => "/tmp/linux-malware-detect-$version",
  #   recurse => true,
  #   purge   => true,
  #   force   => true,
  #   require => File['removearchive'],
  # }
  notify { "/tmp/linux-malware-detect-$version":
    message => "/tmp/linux-malware-detect-$version"
  }
}
