# Class: maldet::config
#
#
class maldet::config {
  file {'/usr/local/maldetect/conf.maldet':
    alias => 'configuring', 
    ensure => file,
    owner  => root,
    group  => root,
    mode   => '0644',
    content => template("maldet/conf.maldet.erb"),
  }
}
