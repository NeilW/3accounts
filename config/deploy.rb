set :application, "3accounts"
set :repository,  "http://accounts4free.rubyforge.org/svn/3accounts/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"
set :user, "rails"
set :deploy_to , "/home/#{user}/#{application}"
set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

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

