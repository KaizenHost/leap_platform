class site_apt  {

  # on couchdb we need to include squeeze in apt preferences,
  # so the cloudant package can pull some packages from squeeze
  # template() must be unquoted !
  if 'couchdb' in $::services {
    $custom_preferences = template("site_apt/preferences.include_squeeze")
  } else {
    $custom_preferences = ''
  }
  class {'apt': custom_preferences => $custom_preferences }

  # enable http://deb.leap.se debian package repository
  include site_apt::leap_repo

  apt::apt_conf { '90disable-pdiffs':
    content => 'Acquire::PDiffs "false";';
  }

  include ::apt::unattended_upgrades

  apt::sources_list { 'secondary.list.disabled':
    content => template('site_apt/secondary.list');
  }

  apt::preferences_snippet { 'facter':
    release  => "${::lsbdistcodename}-backports",
    priority => 999
  }

}
