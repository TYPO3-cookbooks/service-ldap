#
# Cookbook Name:: service-ldap
# Recipe:: default
#
# Copyright 2012, TYPO3 Association
#
# Licensed under the Apache License, Version 2.0 (the"service-ldap::License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an"service-ldap::AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include Helper function
#::Chef::Recipe.send(:include, TYPO3::Docs)

# Must be included in order to have the recipe succeeding at the first run.
include_recipe "apt"

include_recipe "openldap::server"
include_recipe "openldap::client"

Chef::Log.info "node['openldap']['server'] = #{node['openldap']['server']}"
#include_recipe "openldap::auth"
#include_recipe "openldap::master"
