#coding: utf-8
class AdjustGoodsFeeInfosController < BaseController
  table :org,:bill_date,:op_org,:bill_no,:goods_no,:origin_goods_fee,:adjust_goods_fee,:other_adjust_note,:op_user,:op_datetime,:note,:human_state_name

  #POST adjust_goods_fee_infos
  def create
    bill = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(bill)
    bill.carrying_bill_id  = params[:bill_ids].first  unless params[:bill_ids].blank?
    create!
  end

  #PUT adjust_goods_fee_infos/:id/authorize
  #审批运费调整信息
  def pass
    @adjust_goods_fee_info = resource_class.find(params[:id])
    @adjust_goods_fee_info.update_attributes(params[:adjust_goods_fee_info])
    @adjust_goods_fee_info.pass
    flash[:success]="调整申请通过,运费已修改!"
    redirect_to @adjust_goods_fee_info
  end

  #PUT adjust_goods_fee_infos/:id/deny
  #驳回请求
  def deny
    @adjust_goods_fee_info = resource_class.find(params[:id])
    @adjust_goods_fee_info.deny
    flash[:warning]="调整申请被驳回!"
    redirect_to @adjust_goods_fee_info
  end

  #GET adjust_goods_fee_infos/:id/show_operate_form
  #显示操作表单
  def show_operate_form
    @adjust_goods_fee_info = resource_class.find(params[:id])
    render :partial => "operate_form"
  end

  #PUT adjust_goods_fee_infos/:id/re_submit
  #重新上报
  def re_submit
    @adjust_goods_fee_info = resource_class.find(params[:id])
    @adjust_goods_fee_info.update_attributes(params[:adjust_goods_fee_info])
    @adjust_goods_fee_info.re_submit
    redirect_to @adjust_goods_fee_info
  end


  #GET adjust_goods_fee_infos/search
  #查询
  def search
    render :partial => "search"
  end

  #导出查询结果为excel
  #GET adjust_goods_fee_infos/export_excel
  def export_excel
    @search = end_of_association_chain.includes(:carrying_bill). \
      where(["carrying_bills.from_org_id in (?) or adjust_goods_fee_infos.org_id in (?) or adjust_goods_fee_infos.op_org_id in (?)",
             current_user.current_ability_org_ids,
             current_user.current_ability_org_ids,
             current_user.current_ability_org_ids]).search(params[:search]).order(sort_column + ' ' + sort_direction)

    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "adjust_goods_fee_infos.xls"
  end

  #需要重写collection方法
  protected
  def collection
    @search = end_of_association_chain.includes(:carrying_bill). \
      where(["carrying_bills.from_org_id in (?) or adjust_goods_fee_infos.org_id in (?) or adjust_goods_fee_infos.op_org_id in (?)",
             current_user.current_ability_org_ids,
             current_user.current_ability_org_ids,
             current_user.current_ability_org_ids]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
