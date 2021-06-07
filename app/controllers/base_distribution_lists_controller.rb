#coding: utf-8
class BaseDistributionListsController < BaseController
  include BillOperate
  table :bill_date,:org,:human_state_name,:user,:note
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
    @distribution_list = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "distribute.xls"
  end
  #显示提货单据打印界面
  #GET distribution_list/:id/show_print_th_bill
  def show_print_th_bill
    dis_list = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(dis_list)
  end
end
