#coding: utf-8
#货场盘货单到货处理
class ArriveYardInventoriesController < YardInventoriesController
  defaults :resource_class => YardInventory, :collection_name => 'yard_inventories', :instance_name => 'yard_inventory'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "YardInventory",:instance_name => "yard_inventory"
    #到货检查界面
  #GET branch_inventories/:id/before_check
  def before_check
    @yard_inventory = resource_class.find(params[:id])
  end
  #到货检查提交
  #PUT branch_inventories/:id/check
  def check
    @yard_inventory = resource_class.find(params[:id])
    @yard_inventory.update_attributes(params[:yard_inventory])
    @yard_inventory.check
    if @yard_inventory.valid?
      flash[:success] = "数据处理成功!"
      redirect_to :action => :process_handle
    else
      err_msg = ""
      @yard_inventory.errors.full_messages.each do |m|
        err_msg += m
      end
      flash[:error] = err_msg
      render :action => :before_check
    end
  end
  protected
  def collection
    @search = end_of_association_chain.accessible_by(current_ability,:read_arrive).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
