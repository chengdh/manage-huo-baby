# -*- encoding : utf-8 -*-
#部署程序到亿恩的机房
set :rails_env,   "production_EN"
set :unicorn_env, "production_EN"
set :app_env,     "production_EN"

set :application, "il_yanzhao_rails32"
set :repository,  "."
set :branch, "upgrade_to_rails32"
set :deploy_via, :copy
set :copy_cache, true
#
set :scm, :git
server "106.3.45.42",:app,:web,:db,:primary => true
set :user,"lmis"
set :use_sudo,false
default_run_options[:pty]=true

set :deploy_to,"~/app/il_yanzhao_rails32"

require "capistrano-rbenv"
set :rbenv_ruby_version, "1.9.3-p448"
#set unicorn support
require 'capistrano-unicorn'
after 'deploy:restart', 'unicorn:duplicate' # before_fork hook implemented (zero downtime deployments)

before "deploy:assets:precompile", :update_database_yml
desc "根据不同的staging修改数据库名称"
task :update_database_yml do
  replacements = {
    'il_yanzhao_r32_production' => 'il_yanzhao_new_production',
    'localhost' => "116.255.186.172"
  }
  replacements.each do |pattern, sub|
    run "sed -i 's@#{pattern}@#{sub}@' #{release_path}/config/database.yml"
  end
end
