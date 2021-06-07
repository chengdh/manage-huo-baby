#coding: utf-8
#任务管理
class TasksController < BaseController
  include BillOperate
  table  :created_at,:title,:creator,:users_list,:participation_users_list,:accept_date,:submit_date,:human_state_name,:audit_state_des

  #GET tasks/search
  #显示查询窗口
  def search
    render :partial => "search"
  end

  #GET tasks/:id/show_audit_page
  #显示审批界面
  def show_audit_page
    @task = Task.find(params[:id])
  end
  #PUT tasks/:id/do_audit
  #审批操作
  def do_audit
    @task = Task.find(params[:id])
    audit_state = params[:task][:audit_state]
    @task.reject if audit_state.eql?("reject")
    if @task.update_attributes(params[:task])
      flash[:notice] = "审批信息保存成功!"
      redirect_to :action => :show
    else
      flash[:warn] = "审批信息保存失败!"
      redirect_to :action => :show_audit_page
    end
  end
  #PUT tasks/:id/do_send
  #任务下发
  def do_send
    @task = Task.find(params[:id])
    @task.process
    if @task.valid?
      flash[:success] = "数据处理成功!"
    else
      flash[:error] = "数据处理失败"
    end
    redirect_to  :action => :show
  end

  #需要重写collection方法
  protected
  def collection
    if can? :read_all,Task
      @search = end_of_association_chain.search(params[:search])
    else
      @search = end_of_association_chain.where("creator_id" => current_user.id).search(params[:search])
    end
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end
end
