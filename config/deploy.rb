#require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "SeamConnect.com"
set :scm,         :git
set :repository,  "git@github.com:rajmohanb/turnserver.git"
set :branch,      "master"
#set :scm_passphrase, ""
#set :scm_verbose, true

# set :ssh_options, { :forward_agent => true }

# default_run_options[:pty] = true
# ssh_options[:paranoid] = false

# set :scm_username, "rajmohanb"
# set :scm_user, "rajmohanb"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# set :user, 'deploy'
set :user, 'root'
set :use_sudo, false
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache

role :web, "50.116.13.218"                          # Your HTTP server, Apache/etc
role :app, "50.116.13.218"                          # This may be the same as your `Web` server
role :db,  "50.116.13.218", :primary => true # This is where Rails migrations will run
# role :db,  "our slave db-server here"

# to avoid the issue - "sh: bundle not found"
set :default_environment, {
    'PATH' => "/usr/local/rvm/rubies/ruby-1.9.3-p392/bin/:$PATH"
}

#set :bundle_cmd, 'source $/.bash_profile && bundle'


# ssh_options[:keys] = ["/home/rajmohan/.ssh/id_rsa"]

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

after "deploy", "deploy:migrate"
after "deploy:migrate", "deploy:restart"
after "deploy:restart", "deploy:cleanup" 
#after "deploy", "deploy:bundle_gems"
#after "deploy:bundle_gems", "deploy:restart"
# before "deploy:assets:precompile"

namespace :deploy do
  #task :bundle_gems do
  #  run "cd #{deploy_to}/current && bundle install vendor/gems"
  #end
  task :start do ; end
  task :stop do ; end
  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end
