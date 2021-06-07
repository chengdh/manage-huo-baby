#coding: utf-8
#货场盘货清单
class YardInventoriesController < BaseController
  table :bill_date,:bill_no,:from_org,:to_org,:bills_count,:user,:note,:human_state_name
  #GET branch_inventories/before_new
  #新建分理处盘货单
  def before_new ; end

  #GET branch_inventories/new
  def new
    if params[:search].blank?
      flash[:notice] = "请先选择运单!"
      redirect_to :action => :before_new
      return
    end
    carrying_bills = CarryingBill.search(params[:search])
    inventory = resource_class.new(:from_org_id => params[:search][:bills_in_yard],:to_org_id => params[:search][:to_org_id_or_transit_org_id_eq])

    get_resource_ivar || set_resource_ivar(inventory)
    carrying_bills.each do |c|
      inventory.act_load_list_lines.build(:carrying_bill => c,:load_num => c.rest_num,:rest_num => c.rest_num,:branch_reached_num => c.branch_reached_num,:line_type => 'yard')
    end
  end
  #PUT branch_inventories/:id/process_handle
  def process_handle
    bill = resource_class.find(params[:id])
    get_resource_ivar || set_resource_ivar(bill)
    bill.process
    if bill.valid?
      flash[:success] = "数据处理成功!"
    else
      err_msg = ""
      bill.errors.full_messages.each do |m|
        err_msg += m
      end
      flash[:error] = err_msg
    end
    redirect_to  :action => :show
  end
  #Get yard_inventories/:id/export_sms_txt:format
  #导出短信群发文本
  def export_sms_txt
    @yard_inventory = resource_class.find(params[:id])
    respond_to do |format|
      format.text do
        require 'iconv'
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",@yard_inventory.to_sms_txt(@yard_inventory.carrying_bill_ids))
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => 'sms.txt'
      end
    end
  end

  #GET branch_inventories/:id/export_excel
  def export_excel
    inventory = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(inventory)
    xls = render_to_string(:partial => "shared/act_load_lists/excel",:layout => false)
    send_data show_or_hide_fields_for_export(xls),:filename => "inventory.xls"
  end

  #GET branch_inventories/search
  #显示查询窗口
  def search
    render :partial => "search"
  end
  #查询分理处滞留票据
  def search_bills ; end
  #GET branch_inventories/bills_in_branch
  #分理处滞留清单
  def do_search_bills
    @carrying_bills = CarryingBill.includes([:from_org,:to_org]).search(params[:search]).having('rest_num > 0').all
  end

  protected
  #重写collection方法
  def collection
    org_ids = "(#{current_user.current_ability_org_ids.join(',')})"
    @search = end_of_association_chain.where(["from_org_id in #{org_ids} or to_org_id in #{org_ids}"]).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
