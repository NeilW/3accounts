## Generated with 'brightbox' on Wed Jun 11 12:12:33 +0100 2008
gem 'brightbox', '>=2.0.1'
require 'brightbox/recipes'

# The name of your application.  Used for deployment directory and filenames
# and Apache configs. Should be unique on the Brightbox
set :application, "3accounts"

# Primary domain name of your application. Used in the Apache configs
set :domain, "3accounts.co.uk"

## List of servers
server "3accounts.co.uk", :app, :web, :db, :primary => true

# Target directory for the application on the web and app servers.
set(:deploy_to) { File.join("", "home", user, application) }

# URL of your source repository. This is the default one that comes on 
# every Brightbox, you can use your own (we'll let you :)
set :repository, "git://github.com/NeilW/3accounts.git"
set :scm, :git
set :branch, "3report"

### Other options you can set ##
# Comma separated list of additional domains for Apache
# set :domain_aliases, "www.example.com,dev.example.com"

## Local Shared Area
# These are the list of files and directories that you want
# to share between all the releases of your application.
# So if you have an 'upload' directory in public, add 'public/upload'
# to the :local_shared_dirs array.
# If you want to share the database.yml add 'config/database.yml'
# to the :local_shared_files array.
# The shared area is prepared with 'deploy:setup' and all the shared
# items are symlinked in when the code is updated.
# set :local_shared_dirs, %w(public/upload)
# set :local_shared_files, %w(config/database.yml)

# SSL Certificates. If you specify an SSL certificate name then
# the gem will create an 'https' configuration for this application
# TODO: Upload and install the keys on the server
# set :ssl_certificate, "/path/to/certificate/for/my_app.crt"
# set :ssl_key, "/path/to/key/for/my_app.key
# or
# set :ssl_certificate, "name_of_installed_certificate"

# SSH options. The forward agent option is used so that loopback logins
# with keys work properly
# ssh_options[:forward_agent] = true

# Forces a Pty so that svn+ssh repository access will work. You
# don't need this if you are using a different SCM system. Note that
# ptys stop shell startup scripts from running.
default_run_options[:pty] = true

## Logrotation
# Where the logs are stored. Defaults to <shared_path>/log
# set :log_dir, "central/log/path"
# The size at which to rotate a log. e.g 1G, 100M, 5M. Defaults to 100M
# set :log_max_size, "100M"
# How many old compressed logs to keep. Defaults to 10
# set :log_keep, "10"

## Version Control System
# Which version control system. Defaults to subversion if there is
# no 'set :scm' command.
# set :scm, :git
# set :scm_username, "rails"
# set :scm_password, "mysecret"
# or be explicit
# set :scm, :subversion

## Mongrel settings
# Host where mongrel lives. Defaults to the app server
# set :mongrel_host, "127.0.0.1"
# Port number where mongrel starts. Defaults to 9200
# set :mongrel_port, 9200
# Number of mongrel servers to start. Defaults to 2
# set :mongrel_servers, 2

## Deployment settings
# The brightbox gem deploys as the user 'rails' by default and
# into the 'production' environment. You can change these as required.
# set :user, "rails"
# set :rails_env, :production

## Command running settings
# use_sudo is switched off by default so that commands are run
# directly as 'user' by the run command. If you switch on sudo
# make sure you set the :runner variable - which is the user the
# capistrano default tasks use to execute commands.
# NB. This just affects the default recipes unless you use the
# 'try_sudo' command to run your commands.
# set :use_sudo, false
# set :runner, user

## Dependencies
# Set the commands and gems that your application requires. e.g.
# depend :remote, :gem, "will_paginate", ">=2.2.2"
# depend :remote, :command, "brightbox"
