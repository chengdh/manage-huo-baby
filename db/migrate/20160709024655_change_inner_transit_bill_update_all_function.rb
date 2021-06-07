#coding: utf-8
class ChangeInnerTransitBillUpdateAllFunction < ActiveRecord::Migration
  def up
    sf = SystemFunction.find_by_subject_title('内部中转运单(手工)')
    if sf.present?
      sfo = sf.system_function_operates.find_by_name('修改')
      function_obj = {
        :subject => "HandInnerTransitBill",
        :action => :update_all,
        :conditions =>"{:state =>['billed','loaded','shipped','reached','distributed'],:from_org_id => user.current_ability_org_ids}"
      }
      if sfo.present?
        sfo.function_obj = function_obj
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end
    sf = SystemFunction.find_by_subject_title('内部中转运单录入')
    if sf.present?
      sfo = sf.system_function_operates.find_by_name('修改')
      function_obj = {
        :subject => "InnerTransitBill",
        :action => :update_all,
        :conditions =>"{:state => ['billed','loaded','shipped','reached','distributed'],:from_org_id => user.current_ability_org_ids}"
      }
      if sfo.present?
        sfo.function_obj = function_obj
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end
  end
  def down
  end
end
