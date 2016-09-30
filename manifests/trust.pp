#
# = Class: ca::trust
#
class ca::trust (
  $enable = true,
) inherits ca::params {

  include $ca_trust_class

  if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
    include ::ca::trust::redhat
  } elsif $::osfamily == 'Debian' {
  } elsif $::osfamily == 'FreeBSD' {
  } else {
    fail("Class['apache::params']: Unsupported osfamily: ${::osfamily}")
  }

}
