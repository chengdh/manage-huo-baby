#coding: utf-8
#添加修改功能
class AddGoodsExceptionUpdateFunction < ActiveRecord::Migration
  def up
    #修改理赔修改功能
    sf = SystemFunction.find_by_subject_title('货损理赔')
    func_obj =  {
      :subject => "GoodsException",
      :action => :update,
      :conditions => "{:state => ['submited'] }"}

    if sf
      ops = sf.system_function_operates.find_or_create_by_name("提交后修改")
      ops.update_attributes(:function_obj => func_obj)
    end


  end

  def down
  end
end
