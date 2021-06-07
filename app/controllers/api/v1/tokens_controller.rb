#coding: utf-8
#devise token处理
#参考http://matteomelani.wordpress.com/2011/10/17/authentication-for-mobile-devices/
class Api::V1::TokensController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json
  def create
    username = params[:username]
    password = params[:password]
    if request.format != :json
      render :status => 406, :json => {:message => "The request must be json"}
      return
    end

    if username.nil? or password.nil?
      render :status => 400,:json => {:message => "The request must contain the username and password."}
      return
    end

    @user=User.find_by_username(username)
    if @user.nil?
      logger.info("User #{username} failed signin, user cannot be found.")
      render :status => 401, :json => {:message=>"Invalid username or passoword."}
      return
    end

    @user.ensure_authentication_token!

    if not @user.valid_password?(password)
      logger.info("User #{username} failed signin, password \"#{password}\" is invalid")
      render :status => 401, :json => {:message => "Invalid username or password."}
    else
      render :status => 200, :json => {:result => @user.attributes}
    end
  end

  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      logger.info("Token not found.")
      render :status => 404, :json => {:message => "Invalid token." }
    else
      @user.reset_authentication_token!
      render :status => 200, :json => {:token => params[:id]}
    end
  end

  #POST 测试服务器连接
  #/api/v1/tokens/test_connect.json
  def test_connect
    render :status => 200,:json => {:result => "ok"}
  end
end
