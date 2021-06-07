#coding: utf-8
#load_lists controller base class
class BaseLoadListsController < BaseController
  include BillOperate
  table :bill_date,:bill_no,:from_org,:to_org,:driver,:vehicle_no,:human_state_name,:user,:note
  #GET search
  #显示查询窗口
  def search
    render :partial => "shared/load_lists/search"
  end
  def show
    super do |format|
      format.csv {send_data resource.to_csv}
    end
  end
  #GET load_list/1/export_excel
  def export_excel
    load_list = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills]))
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "load_lists.xls"
  end
  #GET load_list/:id/build_act_load_list
  def build_act_load_list
    load_list = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills]))
    @yard_inventory = load_list.build_act_load_list
  end
end
