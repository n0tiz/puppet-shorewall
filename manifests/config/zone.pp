define shorewall::config::zone (
  String $zone,
  Enum['ip', 'ipv4', 'ipv6', 'ipsec', 'ipsec4', 'ipsec6', 'firewall', 'bport', 'vserver', 'loopback', 'local'] $type,
  Array[String] $options = [],
  Array[String] $in_options = [],
  Array[String] $out_options = []
) {
  if $shorewall::service_manage == true {
    $notify = Service['shorewall']
  } else {
    $notify = undef
  }
  if ! defined(Concat['/etc/shorewall/zones']) {
    concat {'/etc/shorewall/zones':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/zones',
      notify => $notify,
    }
    concat::fragment {'zone-header':
      source => 'puppet:///modules/shorewall/zone-header',
      target => '/etc/shorewall/zones',
      order => 1,
      notify => $notify,
    }
  }
  concat::fragment {"zone-${title}":
    content => template('shorewall/zone.erb'),
    target => '/etc/shorewall/zones',
    order => 2,
    notify => $notify,
  }
}