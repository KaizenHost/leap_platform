class site_apache::module::socache_shmcb ( $ensure = present )
{

  apache::module { 'socache_shmcb': ensure => $ensure }
}
