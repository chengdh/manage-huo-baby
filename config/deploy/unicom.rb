# -*- encoding : utf-8 -*-
require 'bundler/capistrano'
require "capistrano-rbenv"
set :rails_env,   "production"
set :unicorn_env, "unicom_production"
set :app_env,     "production"

#add bundler support
require 'bundler/capistrano'
set :application, "il_unicom"
set :repository,  "."
set :branch, "upgrade_to_rails32"
set :deploy_via, :copy
set :copy_cache, true
#本地部署时,gzip出现问题,参考
#http://stackoverflow.com/questions/8590341/capistrano-gzip-stdin-unexpected-end-of-file-interruption
local_user = "lmis"
set :copy_dir, "/home/#{local_user}/tmp"
set :remote_copy_dir, "/tmp"
#
set :scm, :git
server "127.0.0.1",:app,:web,:db,:primary => true
set :user,"lmis"
set :use_sudo,false
default_run_options[:pty]=true

set :deploy_to,"~/app/il_unicom"

#不再使用rvm 使用rbenv部署
set :rbenv_ruby_version, "1.9.3-p392"
#set rvm support
#set :rvm_ruby_string, '1.9.3@rails32_gemset'
#若rvm以user wide 安装,则rvm相关信息设置如下
#set :rvm_path, "~/.rvm"
#set :rvm_bin_path, "~/.rvm/bin"

#若rvm以system wide安装,则rvm设置如下
#set :rvm_path, "/usr/local/rvm"
#set :rvm_bin_path, "/usr/local/rvm/bin"

#require "rvm/capistrano"
#set unicorn support
require 'capistrano-unicorn'
set :unicorn_bin,'unicorn'
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts
before "deploy:assets:precompile", :update_database_yml
desc "根据不同的staging修改数据库名称"
task :update_database_yml do
  replacements = {
    'il_yanzhao_r32_production' => 'unicom_production'
  }
  replacements.each do |pattern, sub|
    run "sed -i 's@#{pattern}@#{sub}@' #{release_path}/config/database.yml"
  end
end
