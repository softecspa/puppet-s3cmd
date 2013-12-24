puppet-s3cmd
============

Install and configure s3cmd (http://s3tools.org/s3cmd) for sync files/directory from/to an S3 bucket

# Example 1
class {"s3cmd":
    access_key  => $aws_access_key,
    secret_key  => $aws_secret_key,
}

s3cmd::sync {"sync-path":
    source      => "/path/to/directory/",
    bucket_name => "mybucket",
    prefix      => "mydirectory/",
    reverse     => true,
    require     => Class["s3cmd"],
}
