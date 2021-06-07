#coding: utf-8
#添加分理处盘货单发货操作
class AddShipFunctionToBranchInventory < ActiveRecord::Migration
  def change
    group_name = "盘货操作"
    subject_title = "分理处盘货单"
    subject = "BranchInventory"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :subject => subject,
      :function => {
        :ship => {:title => "发货",:conditions => "{:state => 'billed'}"},
      }
    }
    SystemFunction.generate_by_hash(sf_hash)
  end
end
