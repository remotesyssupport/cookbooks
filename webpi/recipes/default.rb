#
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: webpi
# Recipe:: default
#
# Copyright 2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

file_name = ::File.basename(node['webpi']['url'])

remote_file "#{Chef::Config[:file_cache_path]}/#{file_name}" do
  source node['webpi']['url']
  checksum node['webpi']['checksum']
  notifies :unzip, "windows_zipfile[webpicmdline]", :immediately
end

windows_zipfile "webpicmdline" do
  path node['webpi']['home']
  source "#{Chef::Config[:file_cache_path]}/#{file_name}"
  action :nothing
end
