define shorewall::setup::zone (
  String $zone,
  Enum['ipv4', 'firewall'] $type,
  Array[String] $options = [],
  Array[String] $in_options = [],
  Array[String] $out_options = []
) {
  if ! defined(Concat['/etc/shorewall/zones']) {
    concat {'/etc/shorewall/zones':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/zones',
    }
    concat::fragment {'/etc/shorewall/zone-header':
      source => 'puppet:///modules/shorewall/zone-header',
      target => '/etc/shorewall/zones',
    }
  }
  concat::fragment {"zone-${title}":
    content => template('shorewall/zone.erb'),
    target => '/etc/shorewall/zones',
  }
}