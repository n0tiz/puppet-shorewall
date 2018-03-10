class shorewall inherits shorewall::params {
  contain shorewall::install
  contain shorewall::config
  contain shorewall::service

  Class['::shorewall::install']
  -> Class['::shorewall::config']
  ~> Class['::shorewall::service']
}