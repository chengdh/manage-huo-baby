#coding: utf-8
#分成报表-宇玖
class DivideRptYujiusController < BaseController
  include BillOperate
  table :org,:mth,:bill_date,:sum_divide_fee,:sum_plus_fee,:sum_deduct_fee,:sum_other_deduct_fee,:sum_fee,:user,:human_state_name
  #新建分成表
  #GET divide_rpt_yujius/before_new
  def before_new ; end

  def new
    org_id = params[:divide_rpt_yujiu][:org_id]
    mth = params[:divide_rpt_yujiu][:mth]
    @divide_rpt_yujiu = nil
    @divide_rpt_yujiu_exist = DivideRptYujiu.first(:conditions => {:mth => mth,:org_id => org_id})
    if @divide_rpt_yujiu_exist.present? 
      flash[:notice] = "分成结算表已存在!"
      @divide_rpt_yujiu = @divide_rpt_yujiu_exist
    else
      @divide_rpt_yujiu  = DivideRptYujiu.generate_divide_rpt_yujiu(org_id,mth)
    end
    if @divide_rpt_yujiu.confirmed?
      render :action => :show
    else
      render :action => :new
    end
  end

  #GET divide_rpt_yujius/1/export_excel
  def export_excel
    divide_rpt_yujiu = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id],:include => [:org,:user]))
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "divide_rpt_yujiu.xls"
  end
 

  protected
  #总部能看到所有数据,分理处分公司只能看自己的
  def collection
    if @current_user.default_org.in_summary?
      @search = end_of_association_chain.search(params[:search])
    else
      @search = end_of_association_chain.where(:org_id => current_user.current_ability_org_ids).search(params[:search])
    end
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
