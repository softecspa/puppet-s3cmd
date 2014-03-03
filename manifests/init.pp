# == Class: s3cmd
#
# This class manage s3cmd tool. Install s3cmd package and push ~/.s3cfg configuration file
#
# === Parameters
#
# [*access_key*]
#   AWS access key. Mandatory
#
# [*secret_key*]
#   AWS secret key. Mandatory
#
# [*https*]
#   boolean. default: true
#   - true: use https
#   - false: not use https
#
# === Examples
#
#  class { 's3cmd':
#   access_key => "xxxxxxxxxx",
#   secret_key => "yyyyyyyyyy",
#  }
#
# === Authors
#
# Felice Pizzurro <felice.pizzurro@softecspa.it>
#
class s3cmd ($access_key='', $secret_key='', $https=true) {

  if ( $access_key == '' or $secret_key == '') {
    fail("Please specify access/secret key!")
  }

  validate_bool($https)

  $use_https = $https ? {
    true  => 'True',
    false => 'False',
  }

  include s3cmd::install
  include s3cmd::config

  Class['s3cmd::install'] -> Class['s3cmd::config']
}
