# == Class: logstashforwarder::repo
#
# This class exists to install and manage yum and apt repositories
# that contain logstashforwarder official logstashforwarder packages
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'logstashforwarder::repo': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Phil Fenstermacher <mailto:phillip.fenstermacher@gmail.com>
# * Ricahrd Pijnenburg <mailto:richard.pijnenburg@elasticsearch.com>
#
class logstashforwarder::repo {

  case $::osfamily {
    'Debian': {
      if !defined(Class['apt']) {
        class { 'apt': }
      }

      apt::source { 'logstashforwarder':
        location    => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/ubuntu/',
        release     => 'logstashforwarder-prod',
        repos       => 'main',
        key         => '5D14BB9A4D883FC38BF3140C096343CA613ECD57',
        key_source  => 'http://skypackages.s3-website-eu-west-1.amazonaws.com/gpg.key',
        include_src => false,
      }
    }
    'RedHat': {
      yumrepo { 'logstashforwarder':
        baseurl  => 'http://packages.elasticsearch.org/logstashforwarder/centos',
        gpgcheck => 1,
        gpgkey   => 'http://packages.elasticsearch.org/GPG-KEY-elasticsearch',
        enabled  => 1,
      }
    }
    default: {
      fail("\"${module_name}\" provides no repository information for OSfamily \"${::osfamily}\"")
    }
  }
}
