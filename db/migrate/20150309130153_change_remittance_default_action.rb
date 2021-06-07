#coding: utf-8
class ChangeRemittanceDefaultAction < ActiveRecord::Migration
  def up
    subject_title = "汇款记录"
    sf = SystemFunction.find_by_subject_title(subject_title)
    default_action = "remittances_path('search[state_ne]' => 'validated')"
    sf.update_attributes(:default_action => default_action)
  end

  def down
  end
end
