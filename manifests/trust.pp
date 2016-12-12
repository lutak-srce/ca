#
# = Class: ca::trust
#
class ca::trust (
  $enable         = true,
  $ca_trust_class = $::ca::params::ca_trust_class,
) inherits ca::params {

  include $ca_trust_class

}
