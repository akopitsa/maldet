# Class: maldet
# ===========================
class maldet (
  String $version     = $maldet::install::version,
  Boolean $email_alert = $maldet::config::email_alert,
){
  contain maldet::install
  contain maldet::config
  contain maldet::postinstall

  Class['::maldet::install']
  -> Class['::maldet::config']
  -> Class['::maldet::postinstall']
}
