#coding: utf-8
class CreateBaseDeliverInfos < ActiveRecord::Migration
  def change
    add_column :deliver_infos,:type,:string,:limit => 60
  end
end
