# Class: install
#
#
class maldet::install inherits maldet  {
  exec {'wget http://www.rfxn.com/downloads/maldetect-current.tar.gz':
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],    
  }
  notify { 'Hello World':
    require => Exec['maldetlatest'],
  }
  notice( 'some-command is going to be executed now' )
  exec { 'extract':
    alias => 'untar',
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],    
  }
  exec { 'install-maldet':
    alias => 'install',
    command => "/tmp/maldetect-$version/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/maldetect-$version",    
  }
  file {'/usr/local/maldetect/conf.maldet':
    alias => 'configuring', 
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb"),
    require => Exec['install-maldet'],    
  }
  file {'/tmp/maldetect-current.tar.gz':
    alias => 'remove',
    ensure  => absent,
    source  => '/tmp/maldetect-current.tar.gz',
    require => File['/usr/local/maldetect/conf.maldet'],
  }  
}
