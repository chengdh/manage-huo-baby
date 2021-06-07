# -*- encoding : utf-8 -*-
#coding: utf-8
module SessionsHelper
  def user_roles_for_select(user)
    ret = user.user_roles.search(:role_is_active_eq => true,:is_select_eq => true).all.map {|ur| [ur.role.name,ur.role.id]} if user.present?
    ret = Role.where(:is_active => true).all.map {|r| [r.name,r.id]} if user.is_admin?
    ret
  end

  def user_orgs_for_select(user)
    if user.is_admin
      Org.where(:is_active => true).all.map{|r| [r.name,r.id]}
    else
      user.user_orgs.search(:org_is_active_eq => true,:is_select_eq => true).all.map{|uo| [uo.org.name,uo.org.id]}
    end
  end
end

