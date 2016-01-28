# puppet-module-apachefixes
===

Module that adds hiera functionality to the puppetlabs apache module

===

# Compatability
---------------
This module is built for use with Puppet v3 on the following OS families (but could work for others as well).

* RHEL 6

===

# Parameters
------------

vhosts
------
Hash with vhosts. See puppetlabs/apache for available parameters.

- *Default*: undef

mods
----
Hash with mods. See puppetlabs/apache for available parameters.

- *Default*: undef

sysconfig_hostname_export
-------------------------
Export hostname in httpd sysconfig file. Available parameters: present, absent.

- *Default*: absent
