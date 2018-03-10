class shorewall::install {
  if $shorewall::package_manage {
    package { $shorewall::package_name:
      ensure => $shorewall::package_ensure,
    }
  }
}