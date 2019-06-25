define shorewall::config::rule (
  Integer $order = 2,
  String $action,
  String $source,
  String $dest,
  String $proto = '-',
  String $dport = '-',
  String $sport = '-',
  String $origdest = '-',
  String $rate = '-',
  String $user = '',
  String $mark = '',
  String $connlimit = '',
  String $time = ''
) {
  if $shorewall::service_manage == true {
    $notify = Service['shorewall']
  } else {
    $notify = undef
  }
  if ! defined(Concat['/etc/shorewall/rules']) {
    concat {'/etc/shorewall/rules':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/rules',
      notify => $notify,
    }
    concat::fragment {'rule-header':
      source => 'puppet:///modules/shorewall/rule-header',
      target => '/etc/shorewall/rules',
      order => 1,
      notify => $notify,
    }
  }
  concat::fragment {"rule-${title}":
    content => template('shorewall/rule.erb'),
    target => '/etc/shorewall/rules',
    order => $order,
    notify => $notify,
  }
}