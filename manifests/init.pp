# Class: maldet
# ===========================
class maldet (
  String $version = $maldet::install::version,
){
  include maldet::install

}
