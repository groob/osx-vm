node 'default' {
  package {"munkitools":
    ensure   => installed,
    provider => "pkgdmg",
    source   => "/Users/vagrant/Desktop/VMware Shared Folders/-vagrant/munkitools2-latest.pkg",
  }
  package {"r10k":
    provider => "gem",
  }
  host { 'munki':
    ensure => present,
    ip     => "192.168.179.1",
    target => '/etc/hosts',
    notify => Exec["flushdnscache"],
  }
  exec { 'flushdnscache':
    command     => "/usr/bin/dscacheutil -flushcache",
    refreshonly => true,
  }
  file {'/Users/Shared/.com.googlecode.munki.checkandinstallatstartup':
    ensure => present,
  }
  exec {"/usr/bin/defaults write /Library/Preferences/ManagedInstalls.plist SoftwareRepoURL \"http://munki/munki_repo\"" :
    require     => Package['munkitools'],
  }
  exec {"/usr/bin/defaults write /Library/Preferences/ManagedInstalls.plist ClientIdentifier \"testvm\"" :
    require     => Package['munkitools'],
  }
  file {'/Users/Shared/r10k':
    ensure => directory,
    owner  => 'vagrant',
    group  => 'admin',
    mode   => '755',
  }
  file {'/Users/Shared/r10k/environments':
    ensure => directory,
    owner  => 'vagrant',
    group  => 'admin',
    mode   => '755',
  }
  file {'/Users/Shared/r10k/cache':
    ensure => directory,
    owner  => 'vagrant',
    group  => 'admin',
    mode   => '755',
  }
  file {'/Users/Shared/r10k/hieradata':
    ensure => directory,
    owner  => 'vagrant',
    group  => 'admin',
    mode   => '755',
  }
}
