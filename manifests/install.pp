# Class: install
#
#
class maldet::install inherits maldet {
  # file { '/tmp/maldet.tar.gz':
  #   ensure => file,
  #   owner  => root,
  #   group  => root,
  #   mode   => 0644,
  #   source => 'puppet:///modules/maldet/maldetect-current.tar.gz',
  # }
  exec {'wget http://www.rfxn.com/downloads/maldetect-current.tar.gz':
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  file {'/tmp/maldetect-current.tar.gz':
    ensure  => file,
    source  => '/tmp/maldetect-current.tar.gz',
    alias   => 'maldetfile',
    require => Exec['maldetlatest'],
  }
  exec { 'extract':
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz -C /tmp/maldetect-current",
    require => File['/tmp/maldetect-current.tar.gz'],
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    alias   => 'extractmaldet',
  }
  exec { 'install-maldet':
    command => "/tmp/maldetect-current/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/maldetect-current",
    require => Exec['extractmaldet'],
  }
  file {'/usr/local/maldetect/conf.maldet':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb")
  }
}
