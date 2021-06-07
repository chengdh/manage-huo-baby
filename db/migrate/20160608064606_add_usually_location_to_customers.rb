#coding: utf-8
#常用发货地
class AddUsuallyLocationToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :usually_location, :string,limit: 200
  end
end
