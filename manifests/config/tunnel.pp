define shorewall::config::tunnel (
  Integer $order = 2,
  String $type,
  String $zone,
  String $gateway = '',
  String $gateway_zone = ''
) {
  if $shorewall::service_manage == true {
    $notify = Service['shorewall']
  } else {
    $notify = undef
  }
  if ! defined(Concat['/etc/shorewall/tunnels']) {
    concat {'/etc/shorewall/tunnels':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/tunnels',
      notify => $notify,
    }
    concat::fragment {'tunnels-header':
      source => 'puppet:///modules/shorewall/tunnel-header',
      target => '/etc/shorewall/tunnels',
      order => 1,
      notify => $notify,
    }
  }
  concat::fragment {"tunnel-${title}":
    content => template('shorewall/tunnel.erb'),
    target => '/etc/shorewall/tunnels',
    order => $order,
    notify => $notify,
  }
}
