# Class: maldet
# ===========================
class maldet (
  String $version = $maldet::install::version,
){
  contain maldet::install
  Class['::maldet::install']

}
