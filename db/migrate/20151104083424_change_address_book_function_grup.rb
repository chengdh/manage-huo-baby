#coding: utf-8
#修改通讯录所属功能组
class ChangeAddressBookFunctionGrup < ActiveRecord::Migration
  def up
    sf_group = SystemFunctionGroup.find_by_name("通讯录")
    subject_title = "科室通讯录"
    sf = SystemFunction.find_by_subject_title(subject_title)

    subject_title_1 = "分理处通讯录"
    sf_1 = SystemFunction.find_by_subject_title(subject_title_1)

    subject_title_2 = "分公司通讯录"
    sf_2 = SystemFunction.find_by_subject_title(subject_title_2)


    if sf_group.present? and sf.present?
      sf.update_attributes(:system_function_group => sf_group)
    end
    if sf_group.present? and sf_1.present?
      sf_1.update_attributes(:system_function_group => sf_group)
    end
    if sf_group.present? and sf_2.present?
      sf_2.update_attributes(:system_function_group => sf_group)
    end

  end

  def down
  end
end
