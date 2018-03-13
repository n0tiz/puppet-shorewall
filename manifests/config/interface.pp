define shorewall::setup::interface (
  String $zone,
  String $interface,
  Array[String] $options = []
) {
  if $shorewall::service_manage == true {
    $notify = Service['shorewall']
  } else {
    $notify = undef
  }
  if ! defined(Concat['/etc/shorewall/interfaces']) {
    concat {'/etc/shorewall/interfaces':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/interfaces',
      notify => $notify,
    }
    concat::fragment {'interfaces-header':
      source => 'puppet:///modules/shorewall/interface-header',
      target => '/etc/shorewall/interfaces',
      order => 1,
      notify => $notify,
    }
  }
  concat::fragment {"interface-${title}":
    content => template('shorewall/interface.erb'),
    target => '/etc/shorewall/interfaces',
    order => 2,
    notify => $notify,
  }
}