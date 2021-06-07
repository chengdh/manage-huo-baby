# -*- encoding : utf-8 -*-
#coding: utf-8
class SendListPostsController < BaseController
  def create
    ivr = resource_class.new(params[resource_class.model_name.underscore])
    get_resource_ivar || set_resource_ivar(ivr)
    if params[:bill_ids].present?
      params[:bill_ids].each do |bill_id|
        #通过运单id获取对应的send_list_line id
        line = CarryingBill.find(bill_id).send_list_line
        if line.present?
          line.post
          ivr.send_list_lines << line
        end
      end
    end
    create!
  end
  #GET search
  #显示查询窗口
  def search
    render :partial => "shared/send_lists/search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
  #GET load_list/1/export_excel
  def export_excel
    @send_list_post = resource_class.find(params[:id],:include => [:org,:user,:carrying_bills])
  end

end

