class site_apache::module::env ( $ensure = present )
{

  apache::module { 'env': ensure => $ensure }
}
