define shorewall::setup::rule (
  String $action,
  String $source,
  String $dest,
  String $proto = '',
  String $dport = '',
  String $sport = '',
  String $origdest = '',
  String $rate = '',
  String $user = '',
  String $mark = '',
  String $connlimit = '',
  String $time = ''
) {
  if ! defined(Concat['/etc/shorewall/rules']) {
    concat {'/etc/shorewall/rules':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/rules',
    }
    concat::fragment {'/etc/shorewall/rule-header':
      source => 'puppet:///modules/shorewall/rule-header',
      target => '/etc/shorewall/rules',
    }
  }
  concat::fragment {"rule-${title}":
    content => template('shorewall/rule.erb'),
    target => '/etc/shorewall/rules',
  }
}