#coding: utf-8
#短驳单
class ShortListsController < BaseController
  include BillOperate
  table :bill_date,:bill_no,:from_org,:to_org,:vehicle_no,:driver,:mobile,:human_state_name,:user
  #GET search
  #显示查询窗口
  def search
    render :partial => "search"
  end

  #GET load_list/1/export_excel
  def export_excel
    short_list = get_resource_ivar || set_resource_ivar(resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills]))
    xls = render_to_string(:partial => "excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "short_lists.xls"
  end
end
