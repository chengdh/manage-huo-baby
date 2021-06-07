# -*- encoding : utf-8 -*-
#coding: utf-8
module UsersHelper
  def user_states_for_select
    [['有效',1],['无效',0]]
  end
  def users_for_select
    User.where(:is_active => true).all.map {|b| ["#{b.real_name}",b.id]}
  end

  #选择机构用户
  def users_option_groups_string(include_department = true,include_branch = true)
    ret = ""
    ret += option_groups_from_collection_for_select(Org.all_summary_orgs,:users_by_default_org_id,:name,:id,:real_name) if include_department
    ret += option_groups_from_collection_for_select(Org.exclude_summary_orgs,:users_by_default_org_id,:name,:id,:real_name) if include_branch
    ret.html_safe

    option_groups_from_collection_for_select(Org.all_summary_orgs,:users_by_default_org_id,:name,:id,:real_name) if include_department
  end
end

