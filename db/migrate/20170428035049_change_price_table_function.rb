#coding: utf-8
#修改价格表显示
class ChangePriceTableFunction < ActiveRecord::Migration
  def up
    group_name = "收货价格参考表"
    subject_title = "分公司运价参考表"
    sf = SystemFunction.find_by_subject_title(subject_title)
    sf_hash = {
      :group_name => group_name,
      :subject_title => "收货价格参考表",
      :function => {}
    }
    sf.update_by_hash(sf_hash) if sf.present?
  end

  def down
  end
end
