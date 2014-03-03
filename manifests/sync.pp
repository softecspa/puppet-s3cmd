# == define s3cmd::sync
#
# Sync a file (or directory) to/from an S3 bucket
#
# === Params
#
# [*source*]
#   path to be maintained aligned. Mandatory
#
# [*bucket_name*]
#   bucket to use for sync. Mandatory
#
# [*single*]
#   Specifies if we want sync a file (true) or a directory (false). Default: false
#
# [*prefix*]
#   Remote name on S3. Default: $source
#
# [*reverse*]
#   Defines the direction of the sync
#      true:  S3 -> local
#      false: local -> S3
#
define s3cmd::sync (
  $source,
  $bucket_name,
  $single  = false,
  $prefix  = false,
  $reverse = false,
  )
{
  // è sbagliato

  $real_prefix_ = $prefix ? {
    false      => '',
    default => $prefix,
  }

  if $reverse {
    if $single {
      $ensure_ = 'present'
    } else {
      $ensure_ = 'directory'
    }

    file {
      $source:  ensure  => $ensure_;
    }

    exec { "sync s3://$bucket_name/$real_prefix --> $source":
      command => "s3cmd sync --no-progress s3://$bucket_name/$real_prefix $source",
      require => File[$source],
    }
  } else {
      exec {"sync $source --> s3://$bucket_name/$real_prefix":
        command => "s3cmd sync --no-progress $source s3://$bucket_name/$real_prefix",
        onlyif  => "stat $source",
      }
  }
}
