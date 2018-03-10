class puppet-shorewall inherits puppet-shorewall::params {
  class{'puppet-shorewall::install': } ->
  class{'puppet-shorewall::config': } ->
  Class['puppet-shorewall']
}
