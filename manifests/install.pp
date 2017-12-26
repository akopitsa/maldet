# Class: install
#
#
class maldet::install (
  String $version = $maldet::version,
) inherits maldet  {
  exec {"wget https://github.com/rfxn/linux-malware-detect/archive/$version.tar.gz":
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  exec { 'extract':
    alias   => 'untar',
    cwd     => "/tmp",
    command => "tar -xzvf $version.tar.gz",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  exec { 'install-maldet':
    alias   => 'install',
    command => "/tmp/linux-malware-detect-$version/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/linux-malware-detect-$version",
  }
}
