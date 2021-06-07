#coding: utf-8
class AddMobileToPayInfo < ActiveRecord::Migration
  def change
    add_column :pay_infos, :mobile, :string,:limit => 11
  end
end
