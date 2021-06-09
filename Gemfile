source 'https://gems.ruby-china.com'
ruby '1.9.3'

gem 'rails', '3.2.7'
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
  gem "jquery-rails", "~> 2.0.2"
  gem "jquery-ui-rails", "~> 0.2.2"
  gem 'fancybox-rails','~> 0.1.4'
end
#解决windows下mysql hanging问题
#gem 'ghazel-mysql2'
gem 'mysql2','~>0.3.11'
gem "will_paginate", "~> 3.0.3"
gem "will-paginate-i18n", "~> 0.1.1"
gem "devise",'~>2.0.4'
gem "cancan",'1.6.7'
#表单中的树形结构选择
gem 'acts_as_tree',:git => 'git://github.com/parasew/acts_as_tree.git'
#form 显示组件
gem 'formtastic', '~>2.2.0'
#state_machine
gem 'state_machine','~>1.1.2'
gem 'inherited_resources', '~>1.3.1'
gem 'dynamic_form','~>1.1.4'
gem 'show_for','~>0.2.4'
gem 'fastercsv','~>1.5.4'
#uuid generator
gem 'uuid','~>2.3.5'
gem 'easy_http_cache','~>2.2'
gem "meta_search","~> 1.1.3"
#js compressor
#gem 'jammit'
gem "default_value_for", "~> 1.0.7"
gem "jquery_notify_bar", "~> 0.0.4"
gem 'unicorn'
gem "rails_config", "~> 0.3.1"
#性能分析工具
#gem 'newrelic_rpm'
#序列化对象字段
gem 'marshaled_attributes',"~> 0.1.0"
#在线更新表结构
gem "lhm", "~> 1.1.0"
#html解析工具
gem "nokogiri", "~> 1.5.5"

#jquery growl like gritter plugin
gem "gritter", "~> 1.0.3"
#whenever用于定义cron task
gem 'whenever', :require => false

#activerecord 修改审计
gem "audited-activerecord", "~> 3.0"
gem 'acts_as_votable', '~> 0.10.0'
gem "paperclip", "~> 4.2"
gem 'rack-utf8_sanitizer'
gem 'rb-readline', '~> 0.5.2'
gem 'china_city', '~> 0.0.4'
gem 'savon', '~> 2.11.0'
gem 'rubyntlm', '~> 0.3.2'
gem 'tinymce-rails'
gem 'tinymce-rails-langs'
gem 'rails_12factor'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
#gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development do
  gem "bullet",'~>2.3.1'
  gem 'web-app-theme', :git =>'git://github.com/pilu/web-app-theme.git'
  gem 'capistrano','~>2.12.0'
  gem 'net-ssh','~> 2.7.0'
  gem 'rvm-capistrano','~> 1.1.0',:require => false
  gem "capistrano-unicorn", "~> 0.1.6"
  gem 'capistrano-rbenv','~> 1.0.2'
  gem "rails-footnotes",'~> 3.7.8'
  #在unix、linux运行环境下不需要
  #gem "win32-open3"   #ruby 1.8
  #gem "win32-open3-19"  #ruby 1.9
end
group :development, :test do
  gem 'rspec-rails','~>2.9.0'
  gem 'i18n_generators','~>1.2.0'
  gem "autotest-growl", "~> 0.2.16"
  gem 'rails-dev-tweaks', '~> 1.1'
end
group :test do
  gem "ZenTest", "~>4.7.0"
  gem "autotest-rails", "~>4.1.2"
  # factory_girl 3.1 不支持ruby1.8.7
  gem 'factory_girl_rails', '~>1.1.0'
  gem 'spork-rails','~>3.2.0'
end
