#coding: utf-8
#分理处盘货确认单
class ArriveBranchInventoriesController < BranchInventoriesController
  defaults :resource_class => BranchInventory, :collection_name => 'branch_inventories', :instance_name => 'branch_inventory'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "BranchInventory",:instance_name => "branch_inventory"
    #到货检查界面
  #GET branch_inventories/:id/before_check
  def before_check
    @branch_inventory = resource_class.find(params[:id])
  end
  #到货检查提交
  #PUT branch_inventories/:id/check
  def check
    @branch_inventory = resource_class.find(params[:id])
    @branch_inventory.update_attributes(params[:branch_inventory])
    @branch_inventory.check
    if @branch_inventory.valid?
      flash[:success] = "数据处理成功!"
      redirect_to :action => :process_handle
    else
      err_msg = ""
      @branch_inventory.errors.full_messages.each do |m|
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
