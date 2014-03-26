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
define s3cmd::get (
  $bucket_name      = '',
  $source_file_name = '',
  $target_path      = '',
  $target_filename  = ''
  ) {

    validate_absolute_path($target_path)
    file {$target_path:
      ensure  => directory,
    }

    $real_source_file_name = $source_file_name? {
      ''      => $name,
      default => $source_file_name
    }

    $filename = inline_template("<%= real_source_file_name.split('/').at(-1) %>")

    $dest = $target_filename?{
      ''      => "${target_path}/${name}",
      default => "${target_path}/${filename}"
    }

    exec { "cp s3://${bucket_name}/${real_source_file_name} -> ${dest}":
      command => "/usr/bin/s3cmd get s3://${bucket_name}/${real_source_file_name} $dest",
      creates => $dest
    }
}
