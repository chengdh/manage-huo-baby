#coding: utf-8
class BaseRefundsController < BaseController
  include BillOperate
  table :bill_date,:from_org,:to_org,:sum_carrying_fee_1st,
    :sum_carrying_fee_2st,:sum_goods_fee,:sum_carrying_fee_th,
    :sum_insured_fee_th,:sum_from_short_carrying_fee_th,
    :sum_to_short_carrying_fee_th,:sum_th_amount,:human_state_name,:user
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
  #导出到excel
  #GET /refounds/:id/export_excel
  def export_excel
    refund = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(refund)
    partial = "excel"
    partial = "excel_group" if params[:show_group].present?
    xls = render_to_string(:partial => partial,:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "refund.xls"
  end

  #导出到excel
  #GET /refounds/export_excel_for_kingdee
  def export_excel_for_kingdee
    refunds = resource_class.search(params[:search],:include => [:from_org,:to_org,:user,:carrying_bills])
    set_collection_ivar(refunds)
    partial = "excel_for_kingdee"
    xls = render_to_string(:partial => partial,:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "refund_for_kingdee.xls"
  end
end
