# == define s3cmd::put
#
# Put a file to an S3 bucket
#
# === Params
#
# [*source*]
#   Source file to be copied to S3
#
# [*bucket_name*]
#   bucket to put the file to
#
# [*prefix*]
#   remote path in which put the file
#
define s3cmd::put (
  $source       = '',
  $bucket_name  = '',
  $prefix       = '',
  ) {
    exec {"cp $source -> s3://$bucket_name/$path":
      command => "s3cmd put $source s3://$bucket_name/$prefix/",
      onlyif  => "stat $source",
    }
}
