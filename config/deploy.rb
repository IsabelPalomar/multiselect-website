require "bundler/capistrano"
require "rvm/capistrano"

set :application, "multiselect"
set :repository,  "git@github.com:lou/multiselect-website.git"
set :rvm_ruby_string, '1.9.3@multiselect' 
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :user, "lou"
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, '/home/lou/data/multiselect'
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "zorcery.net"                          # This may be the same as your `Web` server

# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

namespace :deploy do
  desc "Restart the Thin processes"
  task :restart do
    run "cd #{current_path} && bundle exec thin stop -C /home/lou/thin.yml"
    run "cd #{current_path} && bundle exec thin start -C /home/lou/thin.yml"
  end
end
