#coding: utf-8
class BaseDeliverInfosController < BaseController
  table :org,:deliver_date,:bill_no,:customer_name,:customer_no,:sum_carrying_fee_th,:sum_insured_fee_th,:sum_from_short_carrying_fee_th,:sum_to_short_carrying_fee_th,:sum_carrying_fee_th_total,:sum_goods_fee,:sum_th_amount
  include BillOperate

  #重写index方法
  def index
    super do |format|
      format.html
      format.csv {send_data resource_class.to_csv(@search)}
    end
  end

  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end

  #PUT /deliver_infos/:id/print_count
  #记录提货单的打印次数
  def print_count
    base_deliver_info = DeliverInfo.find(params[:id])
    base_deliver_info.increment!(:print_count)
    get_resource_ivar || set_resource_ivar(base_deliver_info)
  end
end
