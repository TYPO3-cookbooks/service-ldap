name "vagrant"
description "Vagrant development environment for the TYPO3 LDAP cookbook"
override_attributes "node" => {
  "openldap" => {
    "server"      => 'ldap-vagrant.typo3.box'
  }
}
