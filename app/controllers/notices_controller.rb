#coding: utf-8
#到货提醒,用于语音短信提醒
class NoticesController < BaseController
  table :bill_date,:org,:load_list,:state_desc
  #GET new_with_no_delivery
  #从未提货报表创建到货通知清单
  #GET /notices/new_with_no_delivery
  def new_with_no_delivery
    @notice = Notice.new(:org => current_user.default_org,:bill_date => Date.today)
  end

  #GET search
  #显示查询窗口
  def search
    respond_to do |format|
      format.html
      format.js  {render :partial => "search"}
    end
  end
  protected
  #重写create_resource,提高执行速度
  def create_resource(object)
    if params[:bill_ids].present?
      bills = CarryingBill.find(params[:bill_ids])
      object.notice_lines << bills.map {|bill| NoticeLine.new(:carrying_bill => bill,:from_customer_phone => bill.notice_phone_for_arrive,:calling_text => bill.calling_text_for_arrive,:sms_text => bill.sms_text_for_arrive)}
    end
    object.save
  end
end
