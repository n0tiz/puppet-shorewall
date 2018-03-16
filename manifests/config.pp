class shorewall::config {
  file {'/etc/shorewall/shorewall.conf':
    path => '/etc/shorewall/shorewall.conf',
    ensure => file,
    source => 'puppet:///modules/shorewall/shorewall-config',
    group => root,
    mode => '0644',
    owner => root,
  }
}