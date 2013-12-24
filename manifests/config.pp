class s3cmd::config {

  file {"/root/.s3cfg":
    ensure  => present,
    mode    => 600,
    owner   => "root",
    group   => "root",
    content => template("s3cmd/s3cfg.erb"),
  }

  # Fx - Utilizziamo temporaneamente questo file condiviso da tutti gli utenti per poter salvare i war deployati su s3.
  # TODO: implementare qualcosa di piu' raffinato
  file {"/usr/local/etc/.s3cfg":
    ensure  => present,
    mode    => 640,
    owner   => "root",
    group   => "super",
    content => template("s3cmd/s3cfg.erb"),
    require => Group['super'],
  }

}
