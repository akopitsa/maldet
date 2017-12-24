# Class: install
#
#
class maldet::install inherits maldet  {
  exec {'wget http://www.rfxn.com/downloads/maldetect-current.tar.gz':
    alias   => 'maldetlatest',
    cwd     => '/tmp',
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    notify { 'download': notice("Download"), },
  }
  exec { 'extract':
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    notify { 'extract': notice("extract"), },
  }
  exec { 'install-maldet':
    command => "/tmp/maldetect-$version/install.sh",
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
    cwd     => "/tmp/maldetect-$version",
    notify { 'install': notice("install"), },
  }
  file {'/usr/local/maldetect/conf.maldet':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb"),
    require => Exec['install-maldet'],
    notify { 'config': notice("config"), },
  }
  file {'/tmp/maldetect-current.tar.gz':
    ensure  => absent,
    source  => '/tmp/maldetect-current.tar.gz',
    require => File['/usr/local/maldetect/conf.maldet'],
    notify { 'remove': notice("remove"), },
  }  
}
