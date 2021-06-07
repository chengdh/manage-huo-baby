# -*- encoding : utf-8 -*-
set :rails_env,   "production"
set :unicorn_env, "production"
set :app_env,     "production"

set :application, "il_yujiusuyun"
set :deploy_via, :copy
set :copy_cache, true
#
set :repository,  "."
set :branch, "yujiusuyun"
set :scm, :git
server "114.115.130.233",:app,:web,:db,:primary => true
set :ssh_options, {
  :forward_agent => true,
  :port => 1223
}
set :user,"yujiusuyun"
set :use_sudo,false
default_run_options[:pty]=true

set :deploy_to,"~/app/il_yujiusuyun"

require "capistrano-rbenv"
set :rbenv_ruby_version, "1.9.3-p448"
#set unicorn support
require 'capistrano-unicorn'
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)
