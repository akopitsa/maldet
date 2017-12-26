# Class: install
#
#
class maldet::install (
  String $version = $maldet::version,
) inherits maldet  {
  exec {'wget http://www.rfxn.com/downloads/maldetect-current.tar.gz':
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  exec { 'extract':
    alias   => 'untar',
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  exec { 'install-maldet':
    alias   => 'install',
    command => "/tmp/maldetect-$version/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/maldetect-$version",
    before  => Class['maldet::postinstall'],
  }
}
