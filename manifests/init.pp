class shorewall (
  Boolean $package_manage,
  Array[String] $package_name,
  String $package_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure
) {
  contain shorewall::install
  contain shorewall::config
  contain shorewall::service

  Class['::shorewall::install']
  -> Class['::shorewall::config']
  ~> Class['::shorewall::service']
}