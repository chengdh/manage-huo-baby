# -*- encoding : utf-8 -*-
#coding: utf-8
IlYanzhao::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5
  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true 
  # config.after_initialize do
  #   Bullet.enable = false
  #   Bullet.alert = true
  #   Bullet.bullet_logger = true
  #   Bullet.console = true
  #   Bullet.rails_logger = true
  #   Bullet.disable_browser_cache = true
  #   Paperclip.options[:command_path] = "/opt/boxen/homebrew/bin/"
  # end

end
# the notify message will be notified to rails logger, customized logger, growl or xmpp.
# UniformNotifier.active_notifiers.each do |notifier|
#   notifier.out_of_channel_notify(args.join("\n"))
# end

# the notify message will be wrapped by <script type="text/javascript">...</script>,
# you should append the javascript_str at the bottom of http response body.
# for more information, please check https://github.com/flyerhzm/bullet/blob/master/lib/bullet/rack.rb
# responses = []
# UniformNotifier.active_notifiers.each do |notifier|
#   responses << notifier.inline_notify(notify_message)
# end
# javascript_str = responses.join("\n")
