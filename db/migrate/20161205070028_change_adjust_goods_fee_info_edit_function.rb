#coding: utf-8
#修改货款调整上报修改功能
class ChangeAdjustGoodsFeeInfoEditFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('货款/信息调整')
    func_obj =  {
      :subject => "AdjustGoodsFeeInfo",
      :action => :update,
      :conditions =>"{:state => ['submited'],:org_id => user.current_ability_org_ids}"
    }
    if sf
      ops = sf.system_function_operates.find_or_create_by_name("修改")
      ops.update_attributes(:function_obj => func_obj,:new_function_obj => func_obj)
    end
  end

  def down
  end
end
