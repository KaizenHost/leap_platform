class site_apache::module::authz_core ( $ensure = present )
{

  apache::module { 'authz_core': ensure => $ensure }
}
