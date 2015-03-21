#
# Cookbook Name:: service-ldap
# Attributes:: default

default['service-ldap']['foo'] = true
#default['openldap']['slapd_type'] = "master"
default['openldap']['rootpw'] = "password"
default['openldap']['tls_enabled'] = false
