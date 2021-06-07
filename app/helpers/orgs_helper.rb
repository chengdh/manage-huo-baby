#coding: utf-8
module OrgsHelper
  def orgs_for_select(include_summary = true,include_yard = true)
    Org.where(:is_active => true,:is_summary => [include_summary,false],:is_yard => [include_yard,false]).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end

  #only_visible 只是显示可见的机构
  def branches_for_select(include_summary = true,only_visible = false,show_bottom_blank = false)
    ret = []
    if only_visible
      ret = Branch.where(:is_active => true,:is_visible => true,:is_summary => [include_summary,false]).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
    else
      ret = Branch.where(:is_active => true,:is_summary => [include_summary,false]).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
    end
    ret << ["(空)",""] if show_bottom_blank
    ret
  end

  #中转中心
  def yards_for_select
    get_current_yards.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end
  #获取系统中设置的所有中转货场
  def all_yards_for_select
    Org.where(:is_active => true,:is_yard => true).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end

  #分拨中心
  def allocations_for_select
    Org.where(:is_active => true,:is_allocation => true).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end
  #获取总部列表
  def all_summary_orgs_for_select
    Org.where(:is_active => true,:is_summary => true).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end

  #获取非总部机构,不包含总部下属的子机构
  def exclude_summary_orgs_for_select
    Org.where(:is_active => true,:is_summary => false,:parent_id => nil).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end
  #根据当前登录用户的选择机构
  def current_org_for_select
    {current_user.default_org.name => current_user.default_org.id}
  end
  #除去当前机构的机构选择
  def branches_for_select_ex
    Branch.search(:is_active_eq => true,:id_ne => current_user.default_org.id).all.map {|b| ["#{b.name}[#{b.py}]",b.id]}
  end

  #当前登录用户可使用的的org
  def current_ability_orgs_for_select(show_bottom_blank = false)
    default_org = current_user.default_org
    ret = ActiveSupport::OrderedHash.new
    ret["#{default_org.name}[#{default_org.py}]"] = default_org.id
    default_org.children.each {|child_org|  ret["#{child_org.name}[#{child_org.py}]"] = child_org.id if not ['OrgSorting','OrgLoad'].include?(child_org.type) and (child_org.is_active? or child_org.is_visible?)}
    ret << ["(空)",""] if show_bottom_blank
    ret
  end

  #同城配送到货地选择
  def local_town_to_orgs_list(show_bottom_blank = false,only_visible = false)
    ret_orgs = []
    default_org = current_user.default_org

    if default_org.is_summary?
      ret_orgs = default_org.children
    end

    if default_org.in_summary? and default_org.parent_id.present?
      ret_orgs = default_org.parent.children - [default_org]
    end
    ret = ret_orgs.select {|o| [true,only_visible].include?(o.is_visible) and o.is_active}.map {|b| ["#{b.name}[#{b.py}]",b.id]}

    ret << ["(空)",""] if show_bottom_blank
    ret
  end
  #内部中转到货地选择
  def inner_bill_to_orgs_list(show_bottom_blank = false,only_visible = false)
    summary_org_ids = Org.where(:is_active => true,:is_summary => true).pluck(:id)
    summary_org_children_ids= Org.where(:parent_id => summary_org_ids).pluck(:id)
    ret_orgs=Org.search(:is_visible_in => [true,only_visible],:is_active_eq => true,:id_ni => summary_org_ids + summary_org_children_ids + current_user.current_ability_org_ids).all
    ret = ret_orgs.map {|b| ["#{b.name}[#{b.py}]",b.id]}
    ret << ["(空)",""] if show_bottom_blank
    ret
  end
  #当前登录用户可用之外的orgs
  #当前用户默认登录机构为分理处时,只显示分公司和中转部
  #当前登录用户是分公司时,只显示分理处/上级机构/中转部
  #show_summary 显示总公司,默认显示
  #show_bottom_blank 在列表最后显示空选项,默认不显示
  #only_visible 不显示设置为is_visible = false的机构
  def exclude_current_ability_orgs_for_select(with_yard = false,show_summary = true,show_bottom_blank = false,only_visible = false)
    ret_orgs = []
    default_org = current_user.default_org

    #除去当前默认org和当前org的上级机构
    if default_org.in_summary?
      default_org_id = default_org.id
      parent_id = current_user.default_org.parent_id
      exclude_ids =[current_user.default_org.id]
      exclude_ids << parent_id if parent_id.present?
      exclude_ids += Org.where(:parent_id => parent_id).collect(&:id) if parent_id.present?
      exclude_ids += Org.where(:parent_id => default_org_id).collect(&:id)
      yards_ids = get_current_yards.collect(&:id)
      exclude_ids -= yards_ids if with_yard
      exclude_ids.uniq!
      critial = {:is_active_eq => true,:id_ni => exclude_ids}
      critial[:is_visible_eq] = only_visible if only_visible
      ret_orgs = Branch.search(critial).all
    else
      summary_org = Org.find_by_is_summary(true)
      ret_orgs.push(summary_org) if show_summary
      if summary_org.present?
        critial = {:parent_id => summary_org.id,:is_active => true}
        critial[:is_visible] = only_visible if only_visible
        summary_children = Org.where(critial)
        ret_orgs += summary_children
      end
      if with_yard
        ret_orgs += get_current_yards
      end
      ret_orgs.uniq!
      ret_orgs.compact!
    end

    #判断是否限制了到货地
    org_permits = default_org.permit_orgs
    ret_orgs -= org_permits if org_permits.present?

    ret_array = ret_orgs.map {|b| ["#{b.name}[#{b.py}]",b.id]}
    ret_array << ["(空)",""] if show_bottom_blank
    ret_array
  end
  #转换为json，在页面上使用
  def orgs_to_json_on_view
    Org.where(:is_active => true).all.to_json(:only => [:id,:name,:simp_name,:parent_id,:code,
                                                        :carrying_fee_gte_on_insured_fee,:fixed_insured_fee,:is_yard,:is_summary,
                                                        :is_visible,:auto_generate_to_short_carrying_fee,
                                                        :agtscf_rate,:fixed_to_short_carrying_fee,
                                                        :auto_generate_from_short_carrying_fee,
                                                        :agfscf_rate,:fixed_from_short_carrying_fee])
  end
  private
  #根据登录情况得到可以显示的中转货厂
  def get_current_yards
    yards = Org.where(:is_active => true,:is_yard => true)
    # default_org = current_user.default_org
    # if default_org.in_summary?
    #   #当前是总部的某个分理处登录的
    #   yards.delete_if {|yard| yard.parent_id == default_org.parent_id} if default_org.parent_id.present?
    #   #当前是总部登录的
    #   yards.delete_if {|yard| yard.parent_id == default_org.id} if default_org.parent_id.nil?
    # else
    #   yards.delete_if {|yard| yard.parent_id.nil? }
    # end
    yards
  end
  #得到修改权限
  def get_org_edit_permission_class
    ret_class =""
    ret_class="only_edit_lock_time" if can? :only_edit_lock_time,Org
    ret_class="" if can? :update_all,Org
    ret_class
  end

  #得到multi_select group options
  #include_department = true 包含分理处
  #include_branch = true 包含分公司
  def orgs_option_groups_string(include_department = true,include_branch = true)
    ret = ""
    ret += option_groups_from_collection_for_select(Org.all_summary_orgs,:children,:name,:id,:name) if include_department
    ret += content_tag(:optgroup,options_from_collection_for_select(Org.exclude_summary_orgs,:id,:name),:label => "分公司") if include_branch
    ret.html_safe
  end

  #得到multi_select group options
  def branches_option_groups_string
    content_tag(:optgroup,options_from_collection_for_select(Org.exclude_summary_orgs,:id,:name),:label => "分公司")
    # option_groups_from_collection_for_select(Org.exclude_summary_orgs,:children,:name,:id,:name)
  end
end
