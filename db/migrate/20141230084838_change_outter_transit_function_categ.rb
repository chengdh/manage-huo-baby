#coding: utf-8
#外部中转业务
#修改原由外部中转业务所属group
class ChangeOutterTransitFunctionCateg < ActiveRecord::Migration
  def up
    sf_group = SystemFunctionGroup.find_by_name("外部中转业务")
    ['中转运单录入','手工中转运单录入','货物中转','中转提货'].each do |title|
      sf = SystemFunction.find_by_subject_title(title)
      sf.update_attributes(:system_function_group_id => sf_group.id) if sf_group.present?
    end
  end

  def down
  end
end
