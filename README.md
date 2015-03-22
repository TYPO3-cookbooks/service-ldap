Overview
========

This is a Chef Cookbook for setting up LDAP service for TYPO3.

TODO
====

* Modify the schema (add possibility that users can have typo3 extensions associated)
* Insert some dummy data (users / groups) *check* (see below)
* Authenticate user (bind a user)
* Chef Configuration for a master / slave set up
* Add service to read the Rabbit MQ queue for User to update

Vagrant setup
=============

The Cookbook contains a Vagrant setup so that you can run in on your local machine.

For the first installation, consider one good hour to walk through all the steps which will depend on the speed of your network along with the performance of your machine.
There will about 500 Mb to download which includes a virtual machine and the necessary packages.

The first step is to create a VM and provision it.

<pre>

	# Prerequisite: VirtualBox must be > 4.3
	# Download from https://www.virtualbox.org/wiki/Downloads
	VirtualBox --help | grep VirtualBox

	# Prerequisite: vagrant must be > 1.5
	# Download from http://www.vagrantup.com/downloads.html
	vagrant --version

	# Install Vagrant plugin, will be asked anyway later.
	vagrant plugin install vagrant-cachier
	vagrant plugin install vagrant-omnibus
	vagrant plugin install vagrant-berkshelf

	# Fire up the Virtual Machine... this may take some time as it will download an empty VM box
	vagrant up

	# Provision the VM
	vagrant provision

	# Once the machine is set up you can enter the virtual machine by using vagrant itself.
	vagrant ssh

</pre>

The necessary settings for the development environment can be found in the ``recipes/dev_vagrant.rb`` cookbook. All settings
that are different in development should go there.

Working with Berkshelf
======================

In case you want to have the cookbooks included by Berkshelf in your workspace, you can use the following command to vendor them into a directory ``berks-cookbooks``:

    berks vendor -b Berksfile berks-cookbooks

Installation of the software
============================

Vagrant
-------

Vagrant can be downloaded and installed from the website http://www.vagrantup.com/downloads.html

Virtualbox
----------

VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use.
Follow this download link to install it on your system https://www.virtualbox.org/wiki/Downloads

Configure Vagrant file
----------------------

To adjust configuration open ``Vagrantfile`` file and change settings according to your needs.

<pre>
	# Define IP of the virtual machine to access it from the host
	config.vm.network :private_network, "192.168.188.140"

	# Turn on verbose Chef logging if necessary
	chef.log_level      = :debug
</pre>

Working with LDAP
=================

The following notes were taken during the Server Team Sprint 2015-03-22 and were made by Mimi (no LDAP experience at all, so please feel free to
change / correct things if they are wrong).

Reminder: In the Vagrant Box the password for LDAP is ``password`` and the RootDn is ``cn=admin,dc=typo3,dc=box``

Configuration and Configuration Check
-------------------------------------

The SLAPD configuration can be found in ``/etc/ldap/slapd.conf`` and you can use the following command to run a "configuration check"

    slapd -T test -f /etc/ldap/slapd.conf -d 65535

Adding Some Data
----------------

The following command should add some data into the LDAP directory:

    ldapadd -x -D cn=admin,dc=typo3,dc=box -W -f add_content.ldif

with ``add_content.ldif`` containing the following lines:

    dn: dc=typo3,dc=box
    dc: typo3
    o: typo3.box for LDAP server
    description: Root entry for typo3.box
    objectClass: top
    objectclass: dcObject
    objectclass: organization

    dn: ou=People,dc=typo3,dc=box
    objectClass: organizationalUnit
    ou: People

    dn: ou=Groups,dc=typo3,dc=box
    objectClass: organizationalUnit
    ou: Groups

    dn: cn=miners,ou=Groups,dc=typo3,dc=box
    objectClass: posixGroup
    cn: miners
    gidNumber: 5000

    dn: uid=john,ou=People,dc=typo3,dc=box
    objectClass: inetOrgPerson
    objectClass: posixAccount
    objectClass: shadowAccount
    uid: john
    sn: Doe
    givenName: John
    cn: John Doe
    displayName: John Doe
    uidNumber: 10000
    gidNumber: 5000
    userPassword: johnldap
    gecos: John Doe
    loginShell: /bin/bash
    homeDirectory: /home/johN

Further Resources
=================

* Debian and LDAP https://wiki.debian.org/LDAP/OpenLDAPSetup
* Opscode Community LDAP Cookbook https://github.com/opscode-cookbooks/openldap
* LDAP Tutorial from O'Reilly http://quark.humbug.org.au/publications/ldap/ldap_tut_v2.pdf
* LDAP Tutorial from Ubuntu https://help.ubuntu.com/lts/serverguide/openldap-server.html
