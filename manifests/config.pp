class s3cmd::config {

  file { '/root/.s3cfg':
    ensure  => present,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template('s3cmd/s3cfg.erb'),
  }

  file { '/usr/local/etc/.s3cfg':
    ensure  => present,
    mode    => '0640',
    owner   => 'root',
    group   => 'super',
    content => template('s3cmd/s3cfg.erb'),
    require => Group['super'],
  }

}
