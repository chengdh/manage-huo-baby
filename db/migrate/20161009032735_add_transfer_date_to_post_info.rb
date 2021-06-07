#coding:utf-8
class AddTransferDateToPostInfo < ActiveRecord::Migration
  def change
    add_column :post_infos, :transfer_date, :date
  end
end
