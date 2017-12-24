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
  file {'maldetect-current.tar.gz':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => download_content('http://www.rfxn.com/downloads/maldetect-current.tar.gz'),
  }
#   exec { 'download':
#     cwd     => "/tmp",
#     command => "/usr/bin/wget -q http://www.rfxn.com/downloads/maldetect-current.tar.gz -O /tmp/maldetect-current.tar.gz",
# #    require => File['/tmp/maldetect-current.tar.gz'],
#     path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
#   }
  exec { 'extract':
    cwd     => "/tmp",
    command => "tar -xzvf maldetect-current.tar.gz",
    require => File['/tmp/maldetect-current.tar.gz'],
    path    => ['/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'],
  }
  file {'/usr/local/maldetect/conf.maldet':
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb")
  }
}
