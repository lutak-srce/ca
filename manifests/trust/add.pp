#
# = Define: ca::trust::add
#
define ca::trust::add (
  $source  = '',
  $content = '',
  $ensure  = file,
) {

  include ::ca::trust

  $final_source = $content ? {
    /^$/    => $source,
    default => undef,
  }

  $final_content = $content ? {
    /^$/    => undef,
    default => $content,
  }

  file { "${::ca::params::cert_addon_dir}/${name}":
    ensure  => $ensure,
    owner   => root,
    group   => root,
    mode    => '0644',
    source  => $final_source,
    content => $final_content,
    require => Exec['enable_ca_trust'],
    notify  => Exec['update_ca_trust'],
  }

}
