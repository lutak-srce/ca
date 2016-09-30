#
# = Class: ca::trust::redhat
#
class ca::trust::redhat {

  $enable_trust = $::ca::trust::enable

  package { 'ca-certificates': ensure => present, }

  if ( $enable_trust ) {
    exec { 'update_ca_trust':
      command     => '/usr/bin/update-ca-trust extract',
      refreshonly => true,
      notify      => Exec['enable_ca_trust'],
    }
    exec { 'enable_ca_trust':
      command     => '/usr/bin/update-ca-trust enable',
      onlyif      => '/usr/bin/update-ca-trust check 2>&1 | /bin/grep -q "Status: DISABLED."',
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
