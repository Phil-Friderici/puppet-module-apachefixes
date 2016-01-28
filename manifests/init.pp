# Wrapper module for apache
class apachefixes (
  $vhosts                    = undef,
  $mods                      = undef,
  $sysconfig_hostname_export = absent,
) {
  validate_re($sysconfig_hostname_export, '^(present|absent)$',
  "${sysconfig_hostname_export} is not supported for ensure.
  Allowed values are 'present' and 'absent'.")

  if $vhosts {
    validate_hash($vhosts)
    create_resources(apache::vhost,$vhosts)
  }

  if $mods {
    validate_hash($mods)
    create_resources(apache::mod,$mods)
  }

  file_line { '/etc/sysconfig/httpd export hostname':
    ensure  => $sysconfig_hostname_export,
    path    => '/etc/sysconfig/httpd',
    line    => 'export HOSTNAME=`hostname`',
    require => Package['httpd'],
    notify  => Service['httpd'],
  }
}
