# Class: maldet
# ===========================
class maldet (
  String $version     = $maldet::install::version,
  Boolean $email_alert = $maldet::install::email_alert,
){
  contain maldet::install
 
}
