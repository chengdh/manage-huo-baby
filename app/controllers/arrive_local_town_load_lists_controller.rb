#coding: utf-8
#同城快运-到货清单
class ArriveLocalTownLoadListsController < BaseLoadListsController
  defaults :resource_class => LocalTownLoadList, :collection_name => 'local_town_load_lists', :instance_name => 'local_town_load_list'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "LocalTownLoadList",:instance_name => "local_town_load_list"
  #显示导出短信文本界面
  #GET arrive_load_lists/:id/show_export_sms
  def show_export_sms
    load_list = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(load_list)
  end

  #显示提货单据打印界面
  #GET arrive_load_list/:id/show_print_th_bill
  def show_print_th_bill
    load_list = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(load_list)
  end
  #Get arrive_load_lists/:id/export_sms_txt:format
  #导出短信群发文本
  def export_sms_txt
    load_list = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(load_list)
    respond_to do |format|
      format.text do
        #FIXME 垃圾短信公司,客户端软件不支持utf-8格式的导出文件,只能进行转换
        send_txt = Iconv.conv("gb2312//IGNORE","utf-8",load_list.to_sms_txt(params[:bill_ids]))
        send_data send_txt,:type => "text/plain;charset=gb2312;header=present",:filename => 'sms.txt'
      end
    end
  end
  #GET arrive_load_list/:id/build_notice
  #创建到货提醒信息
  def build_notice
    load_list = resource_class.find(params[:id],:include => [:from_org,:to_org,:user,:carrying_bills])
    get_resource_ivar || set_resource_ivar(load_list)
    @notice = load_list.build_notice
  end

  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
