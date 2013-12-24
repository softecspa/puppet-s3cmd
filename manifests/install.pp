# TODO:
#
#wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | sudo apt-key add -
#wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list
#apt-get update && apt-get install s3cmd

class s3cmd::install {
  package {"s3cmd":
    ensure  => present
  }
}
