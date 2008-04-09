#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

set :application, "3accounts"
set :repository,  "git://github.com/NeilW/3accounts.git"
set :branch, "master"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :user, "rails"
set :deploy_to , "/home/#{user}/#{application}"
set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "3accounts.co.uk"
role :web, "3accounts.co.uk"
role :db,  "3accounts.co.uk", :primary => true

# Redefine the application server controls to use monit.

namespace :deploy do
  %W(start stop restart).each do |event|
    desc "#{event} using Monit"
    task event, :except => { :no_release => true } do
      sudo "/usr/sbin/monit -g #{application} #{event} all"
    end
  end
end

