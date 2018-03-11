define shorewall::setup::policy (
  String $source,
  String $dest,
  String $policy,
  String $loglevel,
  String $rate,
  String $connlimit
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
      source => 'puppet:///modules/shorewall/policy-header'
      target => '/etc/shorewall/policy',
    }
  }
  concat::fragment {"policy-${title}"
    content => template('shorewall/policy.erb'),
    target => '/etc/shorewall/policy',
  }
}