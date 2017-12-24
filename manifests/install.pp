# Class: name
#
#
class maldet::install {
  # file { '/tmp/maldet.tar.gz':
  #   ensure => file,
  #   owner  => root,
  #   group  => root,
  #   mode   => 0644,
  #   source => 'puppet:///modules/maldet/maldetect-current.tar.gz',
  # }
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
    mode   => 0644,
    content => template("maldet/conf.maldet.erb")
  }
}
