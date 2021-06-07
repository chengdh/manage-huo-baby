#coding: utf-8
class ChangeRemittanceUpdateFunction3 < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('汇款记录')
    func_obj =  {
      :subject => "Remittance",
      :action => :update,
      :conditions => "{:state => ['draft','complete'] ,:from_org_id => user.current_ability_org_ids}"}
    if sf
      ops = sf.system_function_operates.find_or_create_by_name("录入汇款记录")
      ops.update_attributes(:function_obj => func_obj,:new_function_obj => func_obj)
    end

  end

  def down
  end
end
