define shorewall::setup::policy (
  String $source,
  String $dest,
  Enum['ACCEPT', 'DROP', 'REJECT', 'BLACKLIST', 'QUEUE', 'NFQUEUE', 'CONTINUE', 'NONE'] $policy,
  String $loglevel = '',
  String $rate = '',
  String $connlimit = ''
) {
  if ! defined(Concat['/etc/shorewall/policy']) {
    concat {'/etc/shorewall/policy':
      ensure => present,
      ensure_newline => true,
      owner => root,
      group => root,
      mode => '0644',
      path => '/etc/shorewall/policy',
    }
    concat::fragment {'/etc/shorewall/policy-header':
      source => 'puppet:///modules/shorewall/policy-header',
      target => '/etc/shorewall/policy',
    }
  }
  if $source == 'all' and $dest == 'all' {
    concat::fragment {"policy-${title}":
      order => '20',
      content => template('shorewall/policy.erb'),
      target => '/etc/shorewall/policy',
    }
  } else {
    concat::fragment {"policy-${title}":
      order => '10',
      content => template('shorewall/policy.erb'),
      target => '/etc/shorewall/policy',
    }
  }
}