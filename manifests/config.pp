class shorewall::config {
  file {'/etc':
    path => '/etc',
    ensure => directory,
    group => root,
    mode => '0755',
    owner => root,
  }
  file {'/etc/shorewall':
    path => '/etc/shorewall',
    ensure => directory,
    group => root,
    mode => '0755',
    owner => root,
  }
  file {'/etc/shorewall/shorewall.conf':
    path => '/etc/shorewall/shorewall.conf',
    ensure => file,
    source => 'puppet:///modules/shorewall/shorewall-config',
    group => root,
    mode => '0644',
    owner => root,
  }
}