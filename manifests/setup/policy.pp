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
    concat::fragment {'policy-header':
      source => 'puppet:///modules/shorewall/policy-header',
      target => '/etc/shorewall/policy',
      order => 1,
    }
  }
  if $source == 'all' and $dest == 'all' {
    concat::fragment {"policy-${title}":
      content => template('shorewall/policy.erb'),
      target => '/etc/shorewall/policy',
      order => 3,
    }
  } else {
    concat::fragment {"policy-${title}":
      content => template('shorewall/policy.erb'),
      target => '/etc/shorewall/policy',
      order => 2,
    }
  }
}