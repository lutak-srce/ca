#
# = Define: ca::trust::add
#
define ca::trust::add (
  $source,
  $ensure = file,
) {

  include ::ca::trust

  file { "${::ca::params::cert_addon_dir}/${name}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $source,
    notify  => Exec['update_ca_trust'],
  }

}
