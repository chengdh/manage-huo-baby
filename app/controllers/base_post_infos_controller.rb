#coding: utf-8
class BasePostInfosController < BaseController
  table :bill_date,:org,:sum_goods_fee,:sum_k_carrying_fee,:sum_k_hand_fee,:sum_act_pay_fee,:human_state_name,:user,:note
  include BillOperate
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
      format.text do
        bank = params[:bank].blank? ? "ccb" : params[:bank]
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",resource.to_ccb_txt)  if bank.eql?("ccb")
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",resource.to_spd_txt)  if bank.eql?("spd")
        filename = 'ccb.txt'  if bank.eql?("ccb")
        filename = 'spd.txt'  if bank.eql?("spd")
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => filename
 
        #ccb 建设银行 spd 上海浦东发展银行
        #send_data resource.to_ccb_txt,:filename => 'ccb.txt' if bank.eql?("ccb")
        #send_data resource.to_spd_txt,:filename => 'spd.txt' if bank.eql?("spd")
      end
    end
  end
  #生成凭证
  #GET post_infos/:id/build_accounting_document
  def build_accounting_document
    post_info = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(post_info)
    @cr_lines,@dr_lines,@cr_detail_lines,@dr_detail_lines,@context = post_info.build_accounting_document
  end

  #批量导出为银行转账文本
  #GET post_infos/batch_export_with_bank
  def batch_export_with_bank
    bank = params[:bank].blank? ? "ccb" : params[:bank]
    send_txt = resource_class.batch_export_with_bank(params[:ids],bank)
    respond_to do |format|
      format.text do
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => "#{bank}.txt" 
      end
    end
  end


  #GET post_info/1/export_excel
  def export_excel
    post_info = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(post_info)
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "post_info.xls"
  end
end
