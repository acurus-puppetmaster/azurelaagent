# @summary Install and configure Azure Log Analytics on Windows and Linux
#
# @example Explicit data
#   class { 'azurelaagent':
#     azure_id     => 'your_workspace_id',
#     azure_shared => 'your_shared_key',
#   }
#
# @example Data on yaml file
#   include azurelaagent
#
# @param azure_id
#   Azure workspace ID
# @param azure_shared
#   Azure shared key
# @param azure_domain
#   Azure OMS domain
# @param azure_resource
#   Azure Resource ID
# @param use_proxy
#   True to use a proxy
# @param proxy
#   Proxy URL like [protocol://][user:password@]proxyhost[:port]
class azurelaagent (
  # Data in yaml
  String $azure_id,
  String $azure_shared,

  Optional[String] $ensure,
  # Optional[String] $azure_domain = undef,
  # Optional[String] $azure_resource = undef,

  Optional[Boolean] $use_proxy = false,
  Optional[String] $proxy = undef,
){
  case $::osfamily {
    'RedHat','Debian': {
      class { 'azurelaagent::install_linux':
        azure_id     => $azure_id,
        azure_shared => $azure_shared,
        use_proxy    => $use_proxy,
        proxy        => $proxy,
      }
    }
    'windows': {
      class { 'azurelaagent::install_windows':
        ensure       => $ensure,
        azure_id     => $azure_id,
        azure_shared => $azure_shared,
        use_proxy    => $use_proxy,
        proxy        => $proxy,
      }
    }
    default : {
      fail("The fact 'osfamily' is set to ${::osfamily} which is not supported.")
    }
  } # end case
}


