# -*- encoding : utf-8 -*-
class SessionsController < Devise::SessionsController
  #GET /sessions/new_session_default
  def new_session_default
  end
  #PUT update_session_default
  def update_session_default
    current_user.update_attributes(:default_role_id => params[:cur_role_id],:default_org_id => params[:cur_org_id])
    redirect_to root_path
  end

  #PUT sign_in_mobile
  #手机客户端登陆
  def sign_in_mobile
    ret = nil
    sign_in_result = false
    if params[:username].blank? or params[:password].blank?
      sign_in_result = false
    elsif params[:username].present? and not User.exists?(:username => params[:username])
      sign_in_result = false
    elsif User.exists?(:username => params[:username])
      user = User.find_by_username(params[:username])
      sign_in_result = user.valid_password?(params[:password])
    end
    if sign_in_result
      ret = {
        :username => params[:username],
        :sign_in_result => true,
        :sign_in_message => "用户验证成功"
      }
    else
      ret = {
        :username => params[:username],
        :sign_in_result => false,
        :sign_in_message => "用户名或密码不正确"
      }
    end
    respond_to do |format|
      format.xml {render :xml => ret.to_xml(:root => :sign_in_mobile_response)}
    end

  end

  private
  # 参考https://github.com/plataformatec/devise/wiki/How-To:-Redirect-to-a-specific-page-on-successful-sign-in-out
  def after_sign_in_path_for(resource)
    user_root_path
  end
end
