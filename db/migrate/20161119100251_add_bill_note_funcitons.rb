#coding: utf-8
class AddBillNoteFuncitons < ActiveRecord::Migration
  def up
    group_name = "查询统计"
    subject_title = "运单修改"
    sf = SystemFunction.find_by_subject_title(subject_title)
    if sf.present?
      sfo = sf.system_function_operates.find_by_name("添加运单备注")
      if sfo.blank?
        function_obj = {:subject => "BillNote",:action => "create"}
        sfo = sf.system_function_operates.create(:name => "添加运单备注",
                                                 :function_obj => function_obj)
        sfo.new_function_obj = function_obj
        sfo.save!
      end
    end

  end

  def down
  end
end
