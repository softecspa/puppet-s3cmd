# === Class: s3cmd::install
#
# Install s3cmd
#
# === Authors
#
# Lorenzo Cocchi <lorenzo.cocchi@softecspa.it>
#

class s3cmd::install {

  $project = 's3tools'
  $program = 's3cmd'

  package {
    'git':              ensure  =>  present;
    'python-dateutil':  ensure  =>  present;
    'python-magic':     ensure  =>  present;
    's3cmd':            ensure  =>  absent;
  }

  vcsrepo { "/usr/share/${project}":
    ensure    =>  'master',
    provider  =>  git,
    owner     =>  'root',
    group     =>  'root',
    require   =>  [ Package['git'], ],
    source    =>  "https://github.com/$project/$program.git",
  }

  file { "/usr/share/${project}/$program":
    owner     => 'root',
    group     => 'root',
    mode      => '755',
    require   =>  [ Vcsrepo["/usr/share/${project}"], ],
  }

  file { '/usr/local/bin/s3cmd':
    ensure    =>  'link',
    target    =>  "/usr/share/${project}/$program",
    require   =>  [ Vcsrepo["/usr/share/${project}"], ],
  }

}
