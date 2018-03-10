class n0tiz-shorewall inherits n0tiz-shorewall::params {
  class{'n0tiz-shorewall::install': } ->
  class{'n0tiz-shorewall::config': } ->
  class{'n0tiz-shorewall::service': } ->
  Class['n0tiz-shorewall']
}
