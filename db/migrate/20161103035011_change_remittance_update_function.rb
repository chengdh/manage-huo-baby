#coding: utf-8
#变更汇款记录修改权限
class ChangeRemittanceUpdateFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('汇款记录')
    func_obj =  {
      :subject => "Remittance",
      :action => :update,
      :conditions => "{:state => ['draft','submited'] ,:from_org_id => user.current_ability_org_ids}"}
    if sf
      ops = sf.system_function_operates.find_or_create_by_name("录入汇款记录")
      ops.update_attributes(:function_obj => func_obj)
    end
  end

  def down
  end
end
