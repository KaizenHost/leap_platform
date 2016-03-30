class site_apache::module::mime ( $ensure = present )
{

  apache::module { 'mime': ensure => $ensure }
}
