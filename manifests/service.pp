class n0tiz-shorewall::service {
  if $shorewall::service_manage == true {
    service { 'ntp':
      ensure     => $shorewall::service_ensure,
      enable     => $shorewall::service_enable,
      name       => $shorewall::service_name,
      provider   => $shorewall::service_provider,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}