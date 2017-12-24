# Class: install
#
#
class maldet::install inherits maldet  {
  exec {'wget http://www.rfxn.com/downloads/maldetect-current.tar.gz':
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  file {'/tmp/maldetect-current.tar.gz':
    ensure  => file,
    source  => '/tmp/maldetect-current.tar.gz',
    alias   => 'maldetfile',
    
  }
  exec { 'extract':
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz",
    require => File['maldetfile'],
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    
  }
  exec { 'install-maldet':
    command => "/tmp/maldetect-$version/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/maldetect-$version",
    
  }
  file {'/usr/local/maldetect/conf.maldet':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb"),
    
    alias => 'configfile'
  }
  file {"/tmp/maldetect-$version":
    ensure => absent,
    path => "/tmp/maldetect-$version",
    recurse => true,
    purge => true,
    force => true,
    
  }
}
