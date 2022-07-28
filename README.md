
# azurelaagent

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with azurelaagent](#setup)
    * [What azurelaagent affects](#what-azurelaagent-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with azurelaagent](#beginning-with-azurelaagent)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Description

Install the Azure Log Analytics agent on Linux and Windows.
This is a beta module, feel free to contribute.

## Setup

### What azurelaagent affects

The module have the dependecies:
* puppetlabs-stdlib
* puppetlabs-powershell

### Setup Requirements

* Require powershell version 3 or major to use the Invoke-WebRequest cmdlet

### Beginning with azurelaagent  

Example

To install the agent

```puppet
  class { 'azurelaagent':
    azure_id     => 'your_workspace_id',
    azure_shared => 'your_shared_key',
  }
```

To modify workspace id and key after installation

```puppet
  class { 'azurelaagent::config':
    azure_id     => 'your_workspace_id',
    azure_shared => 'your_shared_key',
  }
```

To modify the proxy settings after installation

Unauthenticated proxy

```puppet
  class {'azurelaagent::config_proxy':
    proxy_server   => 'http://your.proxy:port',
  }
```

Authenticated proxy

```puppet
  class {'azurelaagent::config_proxy':
    proxy_server   => 'http://your.proxy:port',
    proxy_user     => 'username',
    proxy_password => 'password',
  }
```

To remove the proxy settings after installation

```puppet
  class {'azurelaagent::config_proxy':
    ensure => 'absent',
  }
```
### Upgrading the agent
You can install a specific version of the agent by setting hiera variables to control the version downloaded `x64_download_path` and what filename to save the download to `downloaded_script`.
```yaml
azurelaagent::install_linux::x64_download_path: https://github.com/microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_v1.14.12-0/omsagent-1.14.12-0.universal.x64.sh
azurelaagent::install_linux::downloaded_script: omsagent-1.14.12-0.universal.x64.sh
```
To upgrade the agent set the ensure parameter to `latest`
```puppet
  class { 'azurelaagent':
    azure_id     => 'your_workspace_id',
    azure_shared => 'your_shared_key',
    ensure       => latest,
  }
```
And change the hiera variables to point a new version to download and a new filename to save the download.
```yaml
azurelaagent::install_linux::x64_download_path: https://github.com/microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_v1.14.16-0/omsagent-1.14.16-0.universal.x64.sh
azurelaagent::install_linux::downloaded_script: omsagent-1.14.16-0.universal.x64.sh
```
This will cause the new version to be downloaded an an in-place upgrade will occur preserving the original `SourceComputerId` in Azure Log Analytics.

### Uninstalling the agent
To uninstall the agent

```puppet
  class { 'azurelaagent':
    ensure => 'absent',
  }
```

## Usage

If you need to change specific data in Linux or Windows installation use yaml files like

```yaml
azurelaagent::install_linux::x64_download_path: 'https://github.com/Microsoft/OMS-Agent-for-Linux/releases/download/OMSAgent_v1.8.1.256/omsagent-1.8.1-256.universal.x64.sh'
```
```yaml
azurelaagent::install_windows::x64_download_path: 'https://go.microsoft.com/fwlink/?LinkId=828603'
```

## Reference

See reference.

## Limitations

OS compatibility: tested on Ubuntu 16.04 and Windows Server 2012 R2.

## Development

Contributions are welcome!

## Release Notes/Contributors/Etc.
