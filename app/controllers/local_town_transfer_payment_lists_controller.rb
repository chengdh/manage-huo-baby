#coding: utf-8
#同城快运-代收货款支付清单(转账)
class LocalTownTransferPaymentListsController < BaseController
  include BillOperate
  table :bill_date,:bank,:user,:note,:human_state_name

  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv,:filename => 'pufa.csv'}
      format.text do
        bank = params[:bank].blank? ? "ccb" : params[:bank]
        send_data resource.ccb_to_txt,:filename => 'ccb.txt' if bank.eql?("ccb")
        send_data resource.cib_to_txt,:filename => 'cib.txt' if bank.eql?("cib")
      end
    end
  end
  #导出到浦发转账EXCEL
  #GET transfer_payment_list/:id/export_excel
  def export_excel
    transfer_payment_list = resource_class.find(params[:id],:include => [:bank,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(transfer_payment_list)
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "transfer_payment_list.xls"
  end

  #导出短信文件
  #GET transfer_payment_list/:id/export_sms_excel
  def export_sms_excel
    transfer_payment_list = resource_class.find(params[:id],:include => [:bank,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(transfer_payment_list)
    xls = render_to_string(:partial => "sms_excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "transfer_payment_sms.xls"
  end
end
