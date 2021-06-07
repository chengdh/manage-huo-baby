#coding: utf-8
#添加所属货场
class AddYardIdToOrg < ActiveRecord::Migration
  def change
    add_column :orgs, :yard_id, :integer
  end
end
