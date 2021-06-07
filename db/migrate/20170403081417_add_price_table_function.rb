#coding: utf-8
#分公司运价参考表
class AddPriceTableFunction < ActiveRecord::Migration
  def up
    group_name = "查询统计"
    subject_title = "分公司运价参考表"
    subject = "PriceTable"
    sf_hash = {
      :group_name => group_name,
      :subject_title => subject_title,
      :default_action => 'price_tables_path',
      :subject => subject,
      :function => {
        :read =>{:title => "查看"} ,
        :create => {:title => "新建"},
        :update =>{:title =>"修改"},
        :destroy => {:title => "删除"}
      }
    }
    SystemFunction.create_by_hash(sf_hash)
  end

  def down
  end
end
