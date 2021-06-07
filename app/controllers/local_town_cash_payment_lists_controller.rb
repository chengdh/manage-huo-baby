#coding: utf-8
#同城快运-货款支付清单(现金)
class LocalTownCashPaymentListsController < BaseController
  include BillOperate
  table :bill_date,:org,:user,:note
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
  def export_excel
    cash_payment_list = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(cash_payment_list)
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "cash_payment_list.xls"
  end
  #Get cash_payment_lists/:id/export_sms_txt:format
  #导出短信群发文本
  def export_sms_txt
    cash_payment_list = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(cash_payment_list)
    respond_to do |format|
      format.text do
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        require 'iconv'
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",@cash_payment_list.export_sms_txt)
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => 'sms.txt'
        #send_data @cash_payment_list.export_sms_txt,:filename => 'sms.txt'
      end
    end
  end

end
