class site_apache::module::mpm_prefork ( $ensure = present )
{

  apache::module { 'mpm_prefork': ensure => $ensure }
}
