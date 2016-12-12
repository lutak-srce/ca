#
# = Class: ca::trust::redhat
#
class ca::trust::redhat (
  $enable = $::ca::trust::enable,
) {

  package { 'ca-certificates': ensure => present, }

  if ( $enable ) {
    exec { 'enable_ca_trust':
      command     => '/usr/bin/update-ca-trust enable',
      onlyif      => '/usr/bin/update-ca-trust check 2>&1 | /bin/grep -q "Status: DISABLED."',
      before      => Exec['update_ca_trust'],
      refreshonly => true,
      require     => Package['ca-certificates'],
    }
    exec { 'update_ca_trust':
      command     => '/usr/bin/update-ca-trust extract',
      refreshonly => true,
      require     => Package['ca-certificates'],
    }
  } else {
    exec { 'disable_ca_trust':
      command => '/usr/bin/update-ca-trust disable',
      onlyif  => '/usr/bin/update-ca-trust check 2>&1 | /bin/grep -q "Status: ENABLED."',
      require => Package['ca-certificates'],
    }
  }

}
