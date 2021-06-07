# -*- encoding : utf-8 -*-
set :stages, %w(production production_EN px_production local_server cx_production unicom)
set :default_stage, "local_server"

require 'bundler/capistrano'
#添加whenever receipt
require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"


require 'capistrano/ext/multistage'

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{release_path}"
  end
end

namespace :deploy do
  #after "deploy:create_symlink","rvm:trust_rvmrc"
  #自定义系统维护界面
  namespace :web do
    task :disable do
      on_rollback { delete "#{shared_path}/system/maintenance.html" }
      require 'rubygems'
      require 'erb'
      template = File.read("./app/views/layouts/maintenance.html.erb")
      erb = ERB.new(template)
      put erb.result, "#{shared_path}/system/maintenance.html",:mode => 0644
    end
  end
end
