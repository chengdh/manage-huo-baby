# -*- encoding : utf-8 -*-
#coding: utf-8
class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "您无权操作此功能!"
    respond_to do |format|
      format.html {redirect_to "/403.html"}
      format.js {render :js => "$.notifyBar({html: '#{exception.message}',delay: 3000,animationSpeed: 'normal',cls: 'error'});"}
    end
  end
end

