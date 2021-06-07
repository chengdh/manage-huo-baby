#coding: utf-8
class ChangeTypeForPayInfo < ActiveRecord::Migration
  def up
    change_column :pay_infos,:type,:string,:limit => 60
  end

  def down
  end
end
