#coding: utf-8
#实提运费报表
class CarryingFeeThRptsController < BaseController
  before_filter :parse_params
  #分理处实提运费表查询
  def rpt_fenlichu
    if current_user.default_org.in_summary?
      records = resource_class.where(:to_org_id => Org.department_list_ids)
        .group_by_to_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    else
      records = resource_class.where(:to_org_id => Org.department_list_ids).where(:from_org_id => current_user.current_ability_org_ids)
        .group_by_to_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    end
    @group_rpts = records.group_by(&:to_org).sort_by {|org,lines| org.try(:order_by)}
  end
  def rpt_fengongsi
    if current_user.default_org.in_summary?
      records = resource_class.where(:to_org_id =>  Org.department_list_ids)
        .group_by_from_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    else
      records = resource_class.where(:to_org_id =>  Org.department_list_ids,:from_org_id => current_user.current_ability_org_ids)
        .group_by_from_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    end
    @group_rpts = records.group_by(&:from_org).sort_by {|org,lines| org.try(:order_by)}
  end

  #GET carrying_fee_th_rpts/fenlichu_export_excel
  def fenlichu_export_excel

    if current_user.default_org.in_summary?
      records = resource_class.where(:to_org_id => Org.department_list_ids)
        .group_by_to_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    else
      records = resource_class.where(:to_org_id => Org.department_list_ids).where(:from_org_id => current_user.current_ability_org_ids)
        .group_by_to_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    end
    @group_rpts = records.group_by(&:to_org).sort_by {|org,lines| org.try(:order_by)}

    xls = render_to_string(:partial => "fenlichu_excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "to_org_rpts.xls"
  end

  #GET carrying_fee_th_rpts/fengongsi_export_excel
  def fengongsi_export_excel
    if current_user.default_org.in_summary?
      records = resource_class.where(:to_org_id => Org.department_list_ids)
        .group_by_from_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    else
      records = resource_class.where(:to_org_id => Org.department_list_ids,:from_org_id => current_user.current_ability_org_ids)
        .group_by_from_org_id.search(:bill_date_gte => @date_range.first,:bill_date_lte => @date_range.last).all
    end
    @group_rpts = records.group_by(&:from_org).sort_by {|org,lines| org.try(:order_by)}
    xls = render_to_string(:partial => "fengongsi_excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "from_org_rpts.xls"
  end
  private
  #解析传入的参数
  def parse_params
    year = params[:search].try(:[],:year)
    mth = params[:search].try(:[],:mth)
    year = Date.today.year if year.blank?
    mth = Date.today.month if mth.blank?
    #计算当月每天的日期数组
    first_day = DateTime.new(year.to_i,mth.to_i,1).to_date
    last_day = first_day.end_of_month
    @date_range = (first_day..last_day)
  end
end
