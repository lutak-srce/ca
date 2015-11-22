#
# = Class: ca::params
#
class ca::params {

  if $::osfamily == 'RedHat' or $::operatingsystem == 'amazon' {
    $cert_addon_dir = '/etc/pki/ca-trust/source/anchors'
    $ca_trust_class = '::ca::trust::redhat'
  } elsif $::osfamily == 'debian' {
    $cert_addon_dir = '/etc/ssl/ca'
    $ca_trust_class = '::ca::trust::debian'
  } else {
    fail("Class['ca::params']: Unsupported operatingsystem: ${::operatingsystem}")
  }

}
