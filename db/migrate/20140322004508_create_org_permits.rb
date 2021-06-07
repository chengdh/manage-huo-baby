#coding: utf-8
#创建分理处允许到货机构表
class CreateOrgPermits < ActiveRecord::Migration
  def change
    create_table :org_permits do |t|
      t.references :org,:null => false
      t.integer :permit_org_id,:null => false
      t.boolean :is_select,:default => false

      t.timestamps
    end
    add_index :org_permits, :org_id
    add_index :org_permits, :permit_org_id
  end
end
