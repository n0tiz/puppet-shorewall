class shorewall::params (
  Boolean $package_manage,
  Array[String] $package_name,
  String $package_ensure,
  Boolean $service_manage,
  String $service_name,
  Optional[String] $service_provider,
  Boolean $service_enable,
  Enum['running', 'stopped'] $service_ensure
) {

}