# == Class: apachefixes
#
# Full description of class apachefixes here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { apachefixes:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
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
