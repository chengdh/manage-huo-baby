# -*- encoding : utf-8 -*-
#coding: utf-8
#coding: utf-8
module SendersHelper
  #当前机构的送货员信息
  def current_ability_senders
    Sender.where(:is_active => true,:org_id => current_user.default_org.id).all
  end
end

