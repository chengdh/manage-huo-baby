#coding: utf-8
class BaseSettlementsController < BaseController 
  include BillOperate
  table :org,:bill_date,:sum_carrying_fee_th,:sum_insured_fee_th,:sum_from_short_carrying_fee_th,:sum_to_short_carrying_fee_th,:sum_goods_fee,:sum_th_amount,:user,:human_state_name,:note
  def new
    settlement = resource_class.new
    #settlement = resource_class.new_with_org_id if params[:settlement].present?
    set_resource_ivar(settlement)
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
  #GET load_list/1/export_excel
  def export_excel
    settlement = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(settlement)
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "settlement.xls"
  end
  #GET settlements/export_excel_for_kingdee
  def export_excel_for_kingdee
    settlement = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(settlement)
    xls = render_to_string(:partial => "excel_for_kingdee",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "settlement_for_kingdee.xls"
  end

  #直接返款处理
  #PUT settlement/:id/direct_refunded_confirmed
  def direct_refunded_confirmed
    settlement = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(settlement)
    settlement.direct_refunded_confirmed ? flash[:success] = "数据处理成功!" : flash[:error] = "数据处理失败!"
    render  :show
  end
end
