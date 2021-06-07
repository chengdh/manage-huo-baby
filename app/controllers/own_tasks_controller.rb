#coding: utf-8
class OwnTasksController < TasksController
  defaults :resource_class => Task, :collection_name => 'tasks', :instance_name => 'task'
  #先跳过基类的验证,然后重写自己的验证
  skip_authorize_resource
  authorize_resource :class => "Task",:instance_name => "task"

  #GET own_tasks/:id/new_progress_page
  def new_progress_page
    @task = Task.find(params[:id])
  end
  #PUT own_taks/:id/save_progress
  #保存进度信息
  def save_progress
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = "数据保存成功!"
      redirect_to :action => :show
    else
      flash[:warn] = "数据保存失败!"
      redirect_to :action => :new_progress_page
    end
  end

  #GET own_tasks/:id_show_finish_page
  def show_finish_page
    @task = Task.find(params[:id])
  end
  #PUT own_taks/:id/save_finish
  #保存任务完成
  def save_finish
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = "数据保存成功!"
      @task.process
      redirect_to :action => :show
    else
      redirect_to :action => :show_finish_page
      flash[:warn] = "数据保存失败!"
    end
  end


  def collection
    #获取task_users及task_participation_users中的task_id
    task_users_ids = TaskUser.where(:user_id => current_user.id).pluck(:task_id)
    task_par_users_ids = TaskParticipationUser.where(:user_id => current_user.id).pluck(:task_id)
    task_ids = (task_users_ids +task_par_users_ids )
    task_ids.uniq!
    @search = end_of_association_chain.where(:id => task_ids).search(params[:search])
    get_collection_ivar || set_collection_ivar(@search.select("DISTINCT #{resource_class.table_name}.*").order(sort_column + ' ' + sort_direction).paginate(:page => params[:page]))
  end

end
