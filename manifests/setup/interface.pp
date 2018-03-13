define shorewall::setup::interface (
  String $zone,
  String $interface,
  Array[String] $options = []
) {
  if ! defined(Concat['/etc/shorewall/interfaces']) {
    concat {'/etc/shorewall/interfaces':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/interfaces',
    }
    concat::fragment {'interfaces-header':
      source => 'puppet:///modules/shorewall/interface-header',
      target => '/etc/shorewall/interfaces',
    }
  }
  concat::fragment {"interface-${title}":
    content => template('shorewall/interface.erb'),
    target => '/etc/shorewall/interfaces',
  }
}